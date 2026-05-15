#!/usr/bin/env bash
# =============================================================================
# scaffold_py.sh — Scaffold a Python FastMCP stdio server project
# Usage: bash scripts/scaffold_py.sh <server-name>
# Requires: Python 3.10+, uv recommended
# =============================================================================
set -euo pipefail

NAME="${1:-my-mcp-server}"
DIR="${NAME}"
MODULE="${NAME//-/_}"

if [ -d "$DIR" ]; then
  echo "❌  Directory '$DIR' already exists. Aborting." >&2
  exit 1
fi

# Check Python version
PYTHON_VERSION=$(python3 --version 2>&1 | awk '{print $2}')
PYTHON_MAJOR=$(echo "$PYTHON_VERSION" | cut -d. -f1)
PYTHON_MINOR=$(echo "$PYTHON_VERSION" | cut -d. -f2)
if [ "$PYTHON_MAJOR" -lt 3 ] || [ "$PYTHON_MINOR" -lt 10 ]; then
  echo "❌  Python 3.10+ required (found $PYTHON_VERSION)" >&2
  exit 1
fi

HAS_UV=0
command -v uv &>/dev/null && HAS_UV=1

echo "🔧  Scaffolding Python MCP server: $NAME"
mkdir -p "$DIR/tests"
cd "$DIR"

# --- pyproject.toml ---
cat > pyproject.toml << EOF
[project]
name = "${NAME}"
version = "0.1.0"
description = "MCP stdio server"
requires-python = ">=3.10"
dependencies = [
    "mcp[cli]>=1.0",
    "httpx>=0.27",
]

[project.scripts]
${NAME} = "${MODULE}.server:main"

[build-system]
requires = ["hatchling"]
build-backend = "hatchling.build"
EOF

# --- .gitignore ---
cat > .gitignore << 'EOF'
__pycache__/
*.py[cod]
.venv/
dist/
*.egg-info/
.env
.env.local
*.log
EOF

# --- .env.example ---
cat > .env.example << 'EOF'
# Copy to .env and fill in your values
# MY_API_KEY=your-key-here
EOF

# --- server.py (top-level entry, for uv run convenience) ---
cat > server.py << 'EOF'
"""Entry point: uv run server.py or mcp dev server.py"""
from __future__ import annotations
from mcp_server import app as mcp

if __name__ == "__main__":
    mcp.run(transport="stdio")
EOF

# --- package directory ---
mkdir -p "${MODULE}"

cat > "${MODULE}/__init__.py" << EOF
"""${NAME} MCP server package."""
EOF

cat > "${MODULE}/server.py" << 'SERVEREOF'
#!/usr/bin/env python3
"""
MCP stdio server — replace this skeleton with your own tools/resources/prompts.
Documentation: https://modelcontextprotocol.io
"""
from __future__ import annotations

import json
import sys
import logging
from mcp.server.fastmcp import FastMCP, Context

# ─── Logging — always to stderr, never stdout ─────────────────────────────────
logging.basicConfig(
    level=logging.INFO,
    stream=sys.stderr,
    format="%(asctime)s [%(levelname)s] %(name)s — %(message)s",
)
logger = logging.getLogger(__name__)

# ─── Server instance ──────────────────────────────────────────────────────────
app = FastMCP("SERVER_NAME_PLACEHOLDER", version="0.1.0")

# ─── Tools ───────────────────────────────────────────────────────────────────

@app.tool()
async def hello(name: str, ctx: Context) -> str:
    """Return a greeting for a given name.

    Args:
        name: Name to greet
    """
    await ctx.info(f"Greeting {name!r}")
    logger.info("hello tool called for %r", name)
    return f"Hello, {name}! 👋"

# ─── Resources ───────────────────────────────────────────────────────────────

@app.resource("info://server")
def server_info() -> str:
    """Return server metadata as JSON."""
    return json.dumps({"name": "SERVER_NAME_PLACEHOLDER", "version": "0.1.0"}, indent=2)

# ─── Prompts ─────────────────────────────────────────────────────────────────

@app.prompt()
def introduce() -> str:
    """Ask the server to introduce itself."""
    return "Please introduce yourself and list your capabilities."

# ─── Entry point ─────────────────────────────────────────────────────────────

def main() -> None:
    app.run(transport="stdio")

if __name__ == "__main__":
    main()
SERVEREOF

sed -i "s/SERVER_NAME_PLACEHOLDER/$NAME/g" "${MODULE}/server.py"

# --- tests/test_server.py ---
cat > tests/test_server.py << 'TESTEOF'
"""Basic unit tests for the MCP server tools (no MCP protocol needed)."""
import asyncio
import pytest

def test_hello_sync():
    """Basic sanity check that the module imports cleanly."""
    from mcp_server.server import app
    assert app.name == "SERVER_NAME_PLACEHOLDER"

@pytest.mark.asyncio
async def test_tools_registered():
    """Verify expected tools are registered."""
    from mcp_server.server import app
    tools = await app._tool_manager.list_tools()
    tool_names = [t.name for t in tools]
    assert "hello" in tool_names
TESTEOF

sed -i "s/SERVER_NAME_PLACEHOLDER/$NAME/g" tests/test_server.py

# --- README.md ---
cat > README.md << EOF
# ${NAME}

An MCP server using stdio transport, built with FastMCP.

## Development

\`\`\`bash
# With uv (recommended)
uv sync
mcp dev server.py    # opens MCP Inspector in browser

# With pip
pip install -e ".[dev]"
python server.py
\`\`\`

## Testing

\`\`\`bash
uv run pytest tests/
\`\`\`

## Claude Desktop config

Add to \`~/Library/Application Support/Claude/claude_desktop_config.json\` (macOS)
or \`%APPDATA%\\Claude\\claude_desktop_config.json\` (Windows):

\`\`\`json
{
  "mcpServers": {
    "${NAME}": {
      "command": "uv",
      "args": ["--directory", "\$(pwd)", "run", "server.py"]
    }
  }
}
\`\`\`
EOF

# --- Install with uv if available ---
if [ "$HAS_UV" -eq 1 ]; then
  echo ""
  echo "📦  Creating virtual environment and installing dependencies with uv..."
  uv sync --quiet 2>/dev/null || uv pip install "mcp[cli]" httpx --quiet
fi

echo ""
echo "✅  Done! Project created in ./${DIR}/"
echo ""
echo "Next steps:"
echo "  cd ${DIR}"
if [ "$HAS_UV" -eq 1 ]; then
  echo "  mcp dev server.py       # test with MCP Inspector (browser UI)"
  echo "  uv run server.py        # run directly (waits for JSON-RPC on stdin)"
else
  echo "  pip install 'mcp[cli]'  # install dependencies"
  echo "  mcp dev server.py       # test with MCP Inspector (browser UI)"
fi
echo ""
echo "Add your tools in ${MODULE}/server.py."