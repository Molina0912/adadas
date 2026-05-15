# Plugins Complete Reference

Source: <https://opencode.ai/docs/plugins>

## Overview

Plugins extend OpenCode functionality with custom hooks, tools, and integrations. They are TypeScript modules that can hook into various events.

## Plugin Structure

```typescript
import type { Plugin } from "@opencode-ai/plugin"

export default (async (input, options?) => {
  return {
    // Hooks here
  }
}) satisfies Plugin
```

## Plugin Input

```typescript
interface PluginInput {
  client: OpenCodeClient    // OpenCode client instance
  project: Project | null   // Current project (null if global)
  directory: string          // Config directory path
  $: {
    env: (key: string) => string | undefined  // Environment variable
  }
}
```

## Plugin Output (Hooks)

```typescript
interface Hooks {
  // Lifecycle hooks
  config?: (cfg: OpenCodeConfig) => void
  event?: (event: string, data: any) => void

  // Chat hooks
  "chat.message"?: (message: Message) => void
  "chat.params"?: (params: ChatParams) => void
  "chat.headers"?: (headers: Record<string, string>) => void

  // Tool hooks
  "tool.execute.before"?: (input: ToolInput, output: ToolOutput) => void
  "tool.execute.after"?: (input: ToolInput, output: ToolOutput) => void
  "tool.definition"?: (tool: ToolDefinition) => ToolDefinition

  // Command hooks
  "command.execute.before"?: (command: string, args: string[]) => void

  // Shell hooks
  "shell.env"?: (env: Record<string, string>) => Record<string, string>

  // Permission hooks
  "permission.ask"?: (permission: PermissionRequest) => PermissionResponse

  // Experimental hooks
  "experimental.chat.messages.transform"?: (messages: Message[]) => Message[]
  "experimental.chat.system.transform"?: (system: string) => string
  "experimental.session.compacting"?: (session: Session) => Session
  "experimental.compaction.autocontinue"?: () => boolean
  "experimental.text.complete"?: (text: string) => string

  // Special hooks
  tool?: { [toolName: string]: ToolDefinition }
  auth?: AuthHandlers
  provider?: ProviderHandlers
}
```

## Plugin Examples

### Basic Plugin - Send Notifications

```typescript
// .opencode/plugin/notification.ts
import type { Plugin } from "@opencode-ai/plugin"

export default (async ({ client }) => {
  return {
    "tool.execute.after": async (input, output) => {
      if (input.name === "edit" && output.success) {
        client.notification({
          title: "File Modified",
          body: `Modified: ${input.args.filePath}`
        })
      }
    }
  }
}) satisfies Plugin
```

### .env Protection Plugin

```typescript
// .opencode/plugin/env-protect.ts
import type { Plugin } from "@opencode-ai/plugin"

export default (async ({ project }) => {
  return {
    "tool.execute.before": async (input) => {
      if (input.name === "bash" && input.args.command.includes(".env")) {
        const cmd = input.args.command
        if (cmd.includes("cat .env") || cmd.includes("grep .env")) {
          throw new Error("Reading .env files is not allowed")
        }
      }
    }
  }
}) satisfies Plugin
```

### Inject Environment Variables Plugin

```typescript
// .opencode/plugin/inject-env.ts
import type { Plugin } from "@opencode-ai/plugin"

export default (async ({ $ }) => {
  return {
    "shell.env": (env) => {
      return {
        ...env,
        NODE_ENV: $.env("NODE_ENV") || "development",
        API_URL: $.env("API_URL") || "http://localhost:3000",
        LOG_LEVEL: $.env("LOG_LEVEL") || "info"
      }
    }
  }
}) satisfies Plugin
```

### Custom Tools Plugin

```typescript
// .opencode/plugin/custom-tools.ts
import type { Plugin } from "@opencode-ai/plugin"

export default (async () => {
  return {
    tool: {
      "my-custom-tool": {
        description: "Perform custom operation",
        parameters: {
          type: "object",
          properties: {
            action: { type: "string" },
            target: { type: "string" }
          },
          required: ["action"]
        },
        execute: async (args, context) => {
          // Custom tool implementation
          return { result: `Action ${args.action} on ${args.target}` }
        }
      }
    }
  }
}) satisfies Plugin
```

### Logging Plugin

```typescript
// .opencode/plugin/logging.ts
import type { Plugin } from "@opencode-ai/plugin"

export default (async ({ directory }) => {
  const logFile = `${directory}/plugin.log`

  return {
    event: (event, data) => {
      const timestamp = new Date().toISOString()
      const logEntry = `[${timestamp}] ${event}: ${JSON.stringify(data)}\n`

      // Append to log file
      require("fs").appendFileSync(logFile, logEntry)
    },

    "tool.execute.after": async (input, output) => {
      console.log(`[PLUGIN] ${input.name} -> ${output.success ? "OK" : "FAIL"}`)
    }
  }
}) satisfies Plugin
```

### Config Modifier Plugin

```typescript
// .opencode/plugin/config-modifier.ts
import type { Plugin } from "@opencode-ai/plugin"

export default (async () => {
  return {
    config: (cfg) => {
      // Ensure required fields
      if (!cfg.model) {
        cfg.model = "anthropic/claude-sonnet-4-6"
      }

      // Set defaults
      cfg.compaction = cfg.compaction || { auto: true, tail_turns: 15 }

      // Add default permissions
      if (!cfg.permission) {
        cfg.permission = {
          bash: { "git *": "allow", "*": "ask" }
        }
      }
    }
  }
}) satisfies Plugin
```

## Plugin Installation

### Auto-Discovered (No Config)
Place in:
- `.opencode/plugin/*.ts`
- `.opencode/plugins/*.ts`

### Config-Based

```json
{
  "plugin": [
    "plugin-name",
    "plugin-name@1.2.3",
    "./local-plugin.ts",
    ["plugin-name", { "option": "value" }]
  ]
}
```

## Plugin Load Order

1. Built-in plugins
2. Auto-discovered plugins (`.opencode/plugin/`)
3. Config plugins in order
4. Last plugin wins for same hook

## Plugin Events Reference

| Event | Timing | Data |
|-------|--------|------|
| `config` | On init | Merged config |
| `event` | Any event | Event name + data |
| `tool.execute.before` | Before tool | Input + output |
| `tool.execute.after` | After tool | Input + output |
| `tool.definition` | Tool definition | Tool definition |
| `command.execute.before` | Before command | Command + args |
| `shell.env` | Shell start | Environment |
| `permission.ask` | Permission check | Request |
| `chat.message` | Chat message | Message |
| `session.compacting` | Session compaction | Session |

## Compaction Hooks

```typescript
export default (async () => {
  return {
    "experimental.session.compacting": (session) => {
      // Modify session before compaction
      return {
        ...session,
        messages: session.messages.slice(-50) // Keep last 50
      }
    },

    "experimental.compaction.autocontinue": () => {
      // Return true to auto-continue after compaction
      return true
    }
  }
}) satisfies Plugin
```

## Auth Handlers

```typescript
export default (async () => {
  return {
    auth: {
      "provider-name": async (authParams) => {
        // Custom auth flow
        return { accessToken: "...", refreshToken: "..." }
      }
    }
  }
}) satisfies Plugin
```

## Provider Handlers

```typescript
export default (async () => {
  return {
    provider: {
      "custom-provider": async (request) => {
        // Custom provider implementation
        return { content: "...", metrics: {...} }
      }
    }
  }
}) satisfies Plugin
```