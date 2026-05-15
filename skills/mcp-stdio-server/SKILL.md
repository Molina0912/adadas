---
name: mcp-stdio
description: >
  Build production-ready MCP (Model Context Protocol) servers with stdio transport from scratch.
  Use this skill any time the user wants to create, scaffold, implement, debug, or improve an MCP
  server that communicates over stdio — whether they call it "an MCP server", "a local MCP tool",
  "a Claude tool server", "a custom tool for Claude Desktop", or anything similar. Covers TypeScript
  (official SDK with McpServer + Zod) and Python (FastMCP / mcp SDK). Includes tools, resources,
  prompts, error handling, logging rules, testing with MCP Inspector, Claude Desktop integration,
  and deployment. Trigger this skill even when the user says "just help me add a tool to Claude"
  or "I want Claude to be able to call my API" — those almost always map to an MCP server.
---

# MCP stdio Server Skill

Build correct, testable, production-quality MCP servers that run as local stdio subprocesses.

## What stdio transport means

An MCP stdio server is a plain process the host (Claude Desktop, Claude Code, Cursor, etc.)
spawns as a child. All JSON-RPC 2.0 protocol messages flow over **stdin / stdout**.
`stderr` is free for your logs. Zero network config — just a command the host runs.

When to choose stdio vs Streamable HTTP:
- **stdio** → local tools, developer machines, desktop integrations, single-user scripts
- **Streamable HTTP** → remote servers, multi-user, cloud deployments (out of scope here)

## Step 0 — Gather requirements

Before writing any code, clarify:
1. **Language** — TypeScript (Node.js) or Python?
2. **What the server does** — which tools/resources/prompts?
3. **External dependencies** — APIs, databases, filesystem paths, env vars?
4. **Target host** — Claude Desktop, Claude Code, custom client?

Read the appropriate language reference before writing the first line of code:
- TypeScript → `references/typescript.md`
- Python → `references/python.md`

---

## Step 1 — Project scaffold

Run the appropriate scaffold script from `scripts/`:

```bash
# TypeScript
bash scripts/scaffold_ts.sh my-server-name

# Python
bash scripts/scaffold_py.sh my-server-name
```

These create a ready-to-run project with correct `package.json`, `tsconfig.json`, or
`pyproject.toml`. Read the output carefully — it lists every file created.

---

## Step 2 — Implement primitives

MCP has three primitive types. Each maps to a clear use case:

| Primitive | Analogy | When to use |
|-----------|---------|-------------|
| **Tool** | POST endpoint | Do something: call an API, query a DB, write a file |
| **Resource** | GET endpoint | Expose read-only context: schemas, docs, configs |
| **Prompt** | Slash command | Reusable prompt templates with parameters |

Most real-world servers are mostly tools. Add resources and prompts when users would benefit
from pulling context or parameterised templates into the conversation.

### Critical stdio rule — stdout is sacred

The host reads every byte on stdout as JSON-RPC. A single stray print/console.log **breaks the connection silently**.

```
✅ GOOD  → stderr, logging libraries configured to stderr, MCP server.notification()
❌ BAD   → console.log(), print(), fmt.Println(), System.out.println()
```

This rule applies to your code, your dependencies, and any subprocess you spawn.

---

## Step 3 — Error handling pattern

Tools should NEVER throw unhandled exceptions — return structured errors instead:

**TypeScript:**
```typescript
return {
  content: [{ type: "text", text: `Error: ${(e as Error).message}` }],
  isError: true,
};
```

**Python:**
```python
return [types.TextContent(type="text", text=f"Error: {e}")]
```

Use `isError: true` (TS) or `is_error=True` (Python) so the host knows it was a tool
failure, not a protocol error. The LLM can then decide whether to retry or report.

---

## Step 4 — Test with MCP Inspector before connecting to any host

```bash
# TypeScript
npx @modelcontextprotocol/inspector node build/index.js

# Python
npx @modelcontextprotocol/inspector uv run python server.py
# or
mcp dev server.py
```

The Inspector opens a browser UI where you can:
- See all registered tools, resources, and prompts
- Call tools with custom inputs and see raw JSON-RPC
- Watch the protocol handshake in real time
- See stack traces inline (Claude Desktop swallows these)

**Always test with the Inspector first.** It saves hours of config-restart loops.

---

## Step 5 — Connect to Claude Desktop

Edit `~/Library/Application Support/Claude/claude_desktop_config.json` (macOS) or
`%APPDATA%\Claude\claude_desktop_config.json` (Windows):

```json
{
  "mcpServers": {
    "my-server": {
      "command": "node",
      "args": ["/absolute/path/to/build/index.js"],
      "env": {
        "MY_API_KEY": "your-key-here"
      }
    }
  }
}
```

For Python with uv (recommended):
```json
{
  "mcpServers": {
    "my-server": {
      "command": "uv",
      "args": ["--directory", "/absolute/path/to/project", "run", "server.py"]
    }
  }
}
```

**Always use absolute paths.** Restart Claude Desktop after saving. Check the 🔌 icon in
the toolbar — it shows connected servers and any connection errors.

---

## Step 6 — Environment variables and secrets

Never hardcode credentials. Read from `process.env` (TS) or `os.environ` (Python).
Pass them via the `env` block in `claude_desktop_config.json` or set them in the shell
that spawns the host process.

If a required env var is missing, fail loudly at startup:

**TypeScript:**
```typescript
const API_KEY = process.env.MY_API_KEY;
if (!API_KEY) {
  process.stderr.write("MY_API_KEY env var is required\n");
  process.exit(1);
}
```

**Python:**
```python
import os, sys
API_KEY = os.environ.get("MY_API_KEY")
if not API_KEY:
    print("MY_API_KEY env var is required", file=sys.stderr)
    sys.exit(1)
```

---

## Common pitfalls and fixes

| Symptom | Likely cause | Fix |
|---------|-------------|-----|
| Server disconnects instantly | stdout pollution | Find every `console.log` / `print` and redirect to stderr |
| Tools don't appear in Claude | Config path wrong | Use absolute paths; restart Claude Desktop |
| `Tool execution failed` (no detail) | Unhandled exception | Use MCP Inspector to see the real traceback |
| JSON parse error in inspector | stdout pollution during startup | Check imports / module loading for print side effects |
| `No server object found` (Python) | Variable not named `mcp`/`server`/`app` | Rename the FastMCP instance or use `file:object` syntax |
| Types mismatch at runtime | Zod/Pydantic schema wrong | Add explicit `.describe()` to each field |

---

## Security checklist

- [ ] Scope API keys to minimum permissions (read-only where possible)
- [ ] Validate and sanitize all tool inputs before using them in shell commands or SQL
- [ ] Never interpolate tool arguments directly into shell strings → use argument arrays
- [ ] Log every tool invocation with parameters (to stderr/file, not stdout)
- [ ] Rate-limit expensive tools if the server could be called by an agent loop
- [ ] Keep secrets in env vars, never in source code or config files committed to git

---

## Reference files

Read these for language-specific API details, full code examples, and advanced patterns:

- `references/typescript.md` — McpServer, Zod schemas, full TypeScript examples
- `references/python.md` — FastMCP, low-level SDK, full Python examples

Scripts:
- `scripts/scaffold_ts.sh` — TypeScript project scaffolding
- `scripts/scaffold_py.sh` — Python project scaffolding