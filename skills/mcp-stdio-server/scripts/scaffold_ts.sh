#!/usr/bin/env bash
# =============================================================================
# scaffold_ts.sh — Scaffold a TypeScript MCP stdio server project
# Usage: bash scripts/scaffold_ts.sh <server-name>
# =============================================================================
set -euo pipefail

NAME="${1:-my-mcp-server}"
DIR="${NAME}"

if [ -d "$DIR" ]; then
  echo "❌  Directory '$DIR' already exists. Aborting." >&2
  exit 1
fi

echo "🔧  Scaffolding TypeScript MCP server: $NAME"
mkdir -p "$DIR/src"
cd "$DIR"

# --- package.json ---
cat > package.json << 'PKGEOF'
{
  "name": "SERVER_NAME_PLACEHOLDER",
  "version": "0.1.0",
  "description": "MCP stdio server",
  "type": "module",
  "bin": {
    "SERVER_NAME_PLACEHOLDER": "./build/index.js"
  },
  "scripts": {
    "build": "tsc && chmod 755 build/index.js",
    "dev": "tsc --watch",
    "start": "node build/index.js",
    "inspect": "npx @modelcontextprotocol/inspector node build/index.js"
  },
  "files": ["build"],
  "dependencies": {
    "@modelcontextprotocol/sdk": "^1.0.0",
    "zod": "^3.25.0"
  },
  "devDependencies": {
    "@types/node": "^22.0.0",
    "typescript": "^5.5.0"
  }
}
PKGEOF

sed -i "s/SERVER_NAME_PLACEHOLDER/$NAME/g" package.json

# --- tsconfig.json ---
cat > tsconfig.json << 'TSEOF'
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
  "include": ["src/**/*"],
  "exclude": ["node_modules"]
}
TSEOF

# --- .gitignore ---
cat > .gitignore << 'GITEOF'
node_modules/
build/
.env
.env.local
*.log
GITEOF

# --- .env.example ---
cat > .env.example << 'ENVEOF'
# Copy to .env and fill in your values
# MY_API_KEY=your-key-here
ENVEOF

# --- src/index.ts ---
cat > src/index.ts << 'INDEXEOF'
#!/usr/bin/env node
/**
 * MCP stdio server — replace this skeleton with your own tools/resources/prompts.
 * Documentation: https://modelcontextprotocol.io
 */
import { McpServer } from "@modelcontextprotocol/sdk/server/mcp.js";
import { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio.js";
import { z } from "zod";

// ─── Server instance ───────────────────────────────────────────────────────────
const server = new McpServer({
  name: "SERVER_NAME_PLACEHOLDER",
  version: "0.1.0",
});

// ─── Tools ────────────────────────────────────────────────────────────────────

server.tool(
  "hello",
  "Return a greeting for a given name",
  { name: z.string().describe("Name to greet") },
  async ({ name }) => ({
    content: [{ type: "text", text: `Hello, ${name}! 👋` }],
  })
);

// ─── Resources ────────────────────────────────────────────────────────────────

server.resource("info://server", "Server info", async (uri) => ({
  contents: [
    {
      uri: uri.href,
      mimeType: "application/json",
      text: JSON.stringify({ name: "SERVER_NAME_PLACEHOLDER", version: "0.1.0" }),
    },
  ],
}));

// ─── Prompts ──────────────────────────────────────────────────────────────────

server.prompt(
  "introduce",
  "Ask the server to introduce itself",
  {},
  () => ({
    messages: [
      {
        role: "user",
        content: {
          type: "text",
          text: "Please introduce yourself and list your capabilities.",
        },
      },
    ],
  })
);

// ─── Startup ──────────────────────────────────────────────────────────────────

async function main() {
  const transport = new StdioServerTransport();
  await server.connect(transport);
  process.stderr.write(`[${new Date().toISOString()}] MCP server started\n`);
}

main().catch((err) => {
  process.stderr.write(`Fatal error: ${err}\n`);
  process.exit(1);
});
INDEXEOF

sed -i "s/SERVER_NAME_PLACEHOLDER/$NAME/g" src/index.ts

# --- Install dependencies ---
echo ""
echo "📦  Installing dependencies..."
npm install --silent 2>/dev/null || npm install

echo ""
echo "✅  Done! Project created in ./${DIR}/"
echo ""
echo "Next steps:"
echo "  cd ${DIR}"
echo "  npm run build           # compile TypeScript"
echo "  npm run inspect         # test with MCP Inspector"
echo ""
echo "Then add your tools in src/index.ts."