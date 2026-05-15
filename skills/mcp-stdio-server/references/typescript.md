# TypeScript MCP stdio Reference

SDK: `@modelcontextprotocol/sdk` (npm)
Requires: Node.js ≥ 18, TypeScript ≥ 5

---

## Table of Contents
1. [Installation and project setup](#1-installation-and-project-setup)
2. [Server skeleton](#2-server-skeleton)
3. [Registering tools](#3-registering-tools)
4. [Registering resources](#4-registering-resources)
5. [Registering prompts](#5-registering-prompts)
6. [Logging correctly](#6-logging-correctly)
7. [Graceful shutdown](#7-graceful-shutdown)
8. [Advanced: Sampling (server calls LLM)](#8-advanced-sampling)
9. [Full working example](#9-full-working-example)

---

## 1. Installation and project setup

```bash
mkdir my-mcp-server && cd my-mcp-server
npm init -y
npm install @modelcontextprotocol/sdk zod
npm install -D @types/node typescript
```

`package.json` — required fields:
```json
{
  "type": "module",
  "bin": { "my-server": "./build/index.js" },
  "scripts": {
    "build": "tsc && chmod 755 build/index.js",
    "dev": "tsc --watch"
  }
}
```

`tsconfig.json`:
```json
{
  "compilerOptions": {
    "target": "ES2022",
    "module": "Node16",
    "moduleResolution": "Node16",
    "outDir": "./build",
    "rootDir": "./src",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true
  },
  "include": ["src/**/*"]
}
```

---

## 2. Server skeleton

`src/index.ts`:
```typescript
#!/usr/bin/env node
import { McpServer } from "@modelcontextprotocol/sdk/server/mcp.js";
import { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio.js";

const server = new McpServer({
  name: "my-server",
  version: "1.0.0",
});

// Register tools, resources, prompts here (see sections below)

async function main() {
  const transport = new StdioServerTransport();
  await server.connect(transport);
  // ✅ stderr is safe for logs — stdout is reserved for JSON-RPC
  process.stderr.write("MCP server running on stdio\n");
}

main().catch((err) => {
  process.stderr.write(`Fatal: ${err}\n`);
  process.exit(1);
});
```

---

## 3. Registering tools

Tools are functions the LLM can invoke. Define input schemas with Zod.

### Simple tool
```typescript
import { z } from "zod";

server.tool(
  "get_weather",
  "Get current weather for a city",
  {
    city: z.string().describe("City name, e.g. 'Paris'"),
    units: z.enum(["celsius", "fahrenheit"]).default("celsius"),
  },
  async ({ city, units }) => {
    try {
      const data = await fetchWeather(city, units);
      return {
        content: [{ type: "text", text: JSON.stringify(data, null, 2) }],
      };
    } catch (e) {
      return {
        content: [{ type: "text", text: `Error fetching weather: ${(e as Error).message}` }],
        isError: true,
      };
    }
  }
);
```

### Tool with image output
```typescript
server.tool("screenshot", "Take a screenshot", {}, async () => {
  const base64Image = await takeScreenshot();
  return {
    content: [
      { type: "image", data: base64Image, mimeType: "image/png" },
      { type: "text", text: "Screenshot captured." },
    ],
  };
});
```

### Tool with complex Zod schema
```typescript
server.tool(
  "create_task",
  "Create a task in the project tracker",
  {
    title: z.string().min(1).max(200).describe("Task title"),
    priority: z.enum(["low", "medium", "high"]).describe("Task priority"),
    assignee: z.string().email().optional().describe("Assignee email"),
    tags: z.array(z.string()).default([]).describe("List of tags"),
    dueDate: z.string().regex(/^\d{4}-\d{2}-\d{2}$/).optional()
      .describe("Due date in YYYY-MM-DD format"),
  },
  async (input) => {
    const task = await createTask(input);
    return {
      content: [{ type: "text", text: `Task created: ${task.id}` }],
    };
  }
);
```

---

## 4. Registering resources

Resources expose read-only data via URI. They have a name and MIME type.

### Static resource
```typescript
server.resource(
  "config://app/settings",
  "Application settings",
  async (uri) => ({
    contents: [
      {
        uri: uri.href,
        mimeType: "application/json",
        text: JSON.stringify({ maxRetries: 3, timeout: 30 }),
      },
    ],
  })
);
```

### Dynamic resource template
```typescript
import { ResourceTemplate } from "@modelcontextprotocol/sdk/server/mcp.js";

server.resource(
  new ResourceTemplate("users://{userId}/profile", { list: undefined }),
  "User profile",
  async (uri, { userId }) => {
    const profile = await db.users.findById(userId);
    return {
      contents: [
        {
          uri: uri.href,
          mimeType: "application/json",
          text: JSON.stringify(profile),
        },
      ],
    };
  }
);
```

---

## 5. Registering prompts

Prompts are parameterised templates users can invoke from the host UI.

```typescript
server.prompt(
  "code_review",
  "Generate a code review for a file",
  {
    language: z.string().describe("Programming language"),
    code: z.string().describe("The code to review"),
    focus: z.enum(["security", "performance", "style", "all"]).default("all"),
  },
  ({ language, code, focus }) => ({
    messages: [
      {
        role: "user",
        content: {
          type: "text",
          text: `Please review this ${language} code with focus on ${focus}:\n\n\`\`\`${language}\n${code}\n\`\`\``,
        },
      },
    ],
  })
);
```

---

## 6. Logging correctly

The MCP SDK provides a server-side logger that sends notifications to the client (safe):

```typescript
server.server.sendLoggingMessage({
  level: "info",
  data: "Tool invoked: get_weather",
});
```

Or write to stderr directly:
```typescript
process.stderr.write(`[INFO] Tool invoked: get_weather\n`);
```

**Never use `console.log`** — it writes to stdout and corrupts the JSON-RPC stream.

---

## 7. Graceful shutdown

stdio servers get SIGINT when the host terminates. The SDK handles cleanup, but you can hook:

```typescript
process.on("SIGINT", async () => {
  await server.close();
  process.exit(0);
});
```

---

## 8. Advanced: Sampling

Sampling lets a tool call back into the LLM from within its execution:

```typescript
const result = await server.server.createMessage({
  messages: [{ role: "user", content: { type: "text", text: "Summarise this text: ..." } }],
  maxTokens: 500,
});
const summary = result.content.type === "text" ? result.content.text : "";
```

---

## 9. Full working example

A complete, runnable server that wraps a REST API (Open-Meteo, no API key needed):

```typescript
#!/usr/bin/env node
import { McpServer } from "@modelcontextprotocol/sdk/server/mcp.js";
import { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio.js";
import { z } from "zod";

const API_BASE = "https://api.open-meteo.com/v1";

const server = new McpServer({ name: "weather-server", version: "1.0.0" });

server.tool(
  "get_forecast",
  "Get a 7-day weather forecast for any location",
  {
    latitude: z.number().min(-90).max(90).describe("Latitude"),
    longitude: z.number().min(-180).max(180).describe("Longitude"),
    timezone: z.string().default("auto").describe("Timezone string or 'auto'"),
  },
  async ({ latitude, longitude, timezone }) => {
    try {
      const url = new URL(`${API_BASE}/forecast`);
      url.searchParams.set("latitude", String(latitude));
      url.searchParams.set("longitude", String(longitude));
      url.searchParams.set("daily", "temperature_2m_max,temperature_2m_min,weathercode");
      url.searchParams.set("timezone", timezone);

      const res = await fetch(url.toString());
      if (!res.ok) throw new Error(`API error: ${res.status}`);
      const data = await res.json();

      return {
        content: [{ type: "text", text: JSON.stringify(data.daily, null, 2) }],
      };
    } catch (e) {
      return {
        content: [{ type: "text", text: `Failed: ${(e as Error).message}` }],
        isError: true,
      };
    }
  }
);

async function main() {
  await server.connect(new StdioServerTransport());
}

main().catch((e) => {
  process.stderr.write(`Fatal: ${e}\n`);
  process.exit(1);
});
```

Build and run:
```bash
npm run build
npx @modelcontextprotocol/inspector node build/index.js
```