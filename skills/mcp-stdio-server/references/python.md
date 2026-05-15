# Python MCP stdio Reference

SDK: `mcp` (PyPI) — includes FastMCP
Requires: Python ≥ 3.10 (3.12 recommended)
Package manager: `uv` strongly recommended

---

## Table of Contents
1. [Installation and project setup](#1-installation-and-project-setup)
2. [FastMCP server skeleton](#2-fastmcp-server-skeleton)
3. [Registering tools](#3-registering-tools)
4. [Registering resources](#4-registering-resources)
5. [Registering prompts](#5-registering-prompts)
6. [Logging correctly](#6-logging-correctly)
7. [Context object and lifecycle hooks](#7-context-and-lifecycle)
8. [Low-level SDK (when FastMCP isn't enough)](#8-low-level-sdk)
9. [Full working example](#9-full-working-example)

---

## 1. Installation and project setup

```bash
# With uv (recommended)
uv init my-mcp-server
cd my-mcp-server
uv add mcp

# With pip
pip install "mcp[cli]"
```

Minimal `pyproject.toml` (uv creates this automatically):
```toml
[project]
name = "my-mcp-server"
version = "0.1.0"
requires-python = ">=3.10"
dependencies = ["mcp>=1.0"]

[project.scripts]
my-server = "my_mcp_server.server:main"
```

---

## 2. FastMCP server skeleton

`server.py`:
```python
from mcp.server.fastmcp import FastMCP

mcp = FastMCP("my-server", version="1.0.0")

# Register tools, resources, prompts here (see sections below)

if __name__ == "__main__":
    mcp.run(transport="stdio")
```

Run with uv (for isolation):
```bash
uv run server.py
# or for dev with inspector:
mcp dev server.py
```

---

## 3. Registering tools

FastMCP derives the JSON Schema from Python type hints and docstrings automatically.

### Synchronous tool
```python
@mcp.tool()
def add_numbers(a: float, b: float) -> float:
    """Add two numbers together.

    Args:
        a: First number
        b: Second number
    Returns:
        The sum of a and b
    """
    return a + b
```

### Async tool (for I/O: HTTP calls, DB queries, filesystem)
```python
import httpx

@mcp.tool()
async def fetch_url(url: str, timeout: int = 10) -> str:
    """Fetch the content of a URL and return it as text.

    Args:
        url: The URL to fetch
        timeout: Request timeout in seconds (default 10)
    """
    async with httpx.AsyncClient() as client:
        response = await client.get(url, timeout=timeout)
        response.raise_for_status()
        return response.text
```

### Tool with complex types (Pydantic models work too)
```python
from pydantic import BaseModel, Field
from typing import Optional, List

class SearchParams(BaseModel):
    query: str = Field(description="Search query string")
    max_results: int = Field(default=10, ge=1, le=100, description="Number of results (1-100)")
    filters: List[str] = Field(default_factory=list, description="Optional filter tags")

@mcp.tool()
async def search_documents(params: SearchParams) -> dict:
    """Search through the document index."""
    results = await index.search(params.query, params.max_results, params.filters)
    return {"results": results, "total": len(results)}
```

### Error handling in tools
```python
import sys

@mcp.tool()
async def call_api(endpoint: str, payload: dict) -> dict:
    """Call an internal API endpoint."""
    try:
        async with httpx.AsyncClient() as client:
            res = await client.post(f"https://api.internal/{endpoint}", json=payload)
            res.raise_for_status()
            return res.json()
    except httpx.HTTPStatusError as e:
        raise ValueError(f"API returned {e.response.status_code}: {e.response.text}")
    except Exception as e:
        print(f"Tool error in call_api: {e}", file=sys.stderr)
        raise
```

---

## 4. Registering resources

Resources expose read-only data via URIs.

### Static resource
```python
@mcp.resource("config://settings")
def get_settings() -> str:
    """Return application configuration."""
    import json
    return json.dumps({"version": "1.0", "max_records": 1000}, indent=2)
```

### Dynamic resource template
```python
@mcp.resource("users://{user_id}/profile")
async def get_user_profile(user_id: str) -> str:
    """Fetch a user profile by ID."""
    profile = await db.get_user(user_id)
    if not profile:
        raise ValueError(f"User {user_id!r} not found")
    return profile.model_dump_json(indent=2)
```

### Resource returning binary (e.g., a file)
```python
from mcp.server.fastmcp import Image

@mcp.resource("file://report/{filename}")
def get_report_file(filename: str) -> bytes:
    """Return a report file as bytes."""
    path = REPORTS_DIR / filename
    if not path.exists():
        raise FileNotFoundError(f"Report {filename!r} not found")
    return path.read_bytes()
```

---

## 5. Registering prompts

```python
@mcp.prompt()
def debug_error(
    error_message: str,
    language: str = "Python",
    code_snippet: str = "",
) -> str:
    """Generate a debugging prompt for a code error."""
    snippet_section = f"\n\nCode:\n```{language.lower()}\n{code_snippet}\n```" if code_snippet else ""
    return (
        f"I'm getting this {language} error and need help debugging it:\n\n"
        f"```\n{error_message}\n```"
        f"{snippet_section}\n\n"
        f"Please explain what's wrong and how to fix it step by step."
    )
```

---

## 6. Logging correctly

**Never use `print()` without `file=sys.stderr`** — stdout is the JSON-RPC channel.

```python
import sys
import logging

logging.basicConfig(
    level=logging.INFO,
    stream=sys.stderr,
    format="%(asctime)s [%(levelname)s] %(message)s",
)
logger = logging.getLogger(__name__)

@mcp.tool()
async def my_tool(x: str) -> str:
    logger.info("my_tool called with x=%r", x)
    result = do_work(x)
    logger.info("my_tool returning %r", result)
    return result
```

Using FastMCP's built-in context logger (sends to client as MCP notifications):
```python
from mcp.server.fastmcp import Context

@mcp.tool()
async def my_tool(query: str, ctx: Context) -> str:
    await ctx.info(f"Processing query: {query!r}")
    result = do_work(query)
    await ctx.info(f"Done, result length: {len(result)}")
    return result
```

---

## 7. Context and lifecycle

The `Context` parameter (injected automatically when present) provides:
- `ctx.info/debug/warning/error(msg)` — MCP logging notifications
- `ctx.report_progress(current, total)` — progress updates to client
- `ctx.request_context` — raw request metadata

```python
@mcp.tool()
async def process_large_dataset(file_path: str, ctx: Context) -> str:
    """Process a large file with progress reporting."""
    records = load_records(file_path)
    results = []
    for i, record in enumerate(records):
        results.append(process_record(record))
        if i % 100 == 0:
            await ctx.report_progress(i, len(records))
    return f"Processed {len(results)} records"
```

Lifecycle hooks:
```python
from contextlib import asynccontextmanager

@asynccontextmanager
async def lifespan(app):
    await db.connect()
    yield
    await db.disconnect()

mcp = FastMCP("my-server", lifespan=lifespan)
```

---

## 8. Low-level SDK

When you need direct JSON-RPC control (custom transports, raw message handling):

```python
import asyncio
import mcp.server.stdio
import mcp.types as types
from mcp.server.lowlevel import Server, NotificationOptions
from mcp.server.models import InitializationOptions

server = Server("low-level-server")

@server.list_tools()
async def handle_list_tools() -> list[types.Tool]:
    return [
        types.Tool(
            name="echo",
            description="Echo back the input",
            inputSchema={
                "type": "object",
                "properties": {"message": {"type": "string"}},
                "required": ["message"],
            },
        )
    ]

@server.call_tool()
async def handle_call_tool(name: str, arguments: dict) -> list[types.TextContent]:
    if name == "echo":
        return [types.TextContent(type="text", text=arguments["message"])]
    raise ValueError(f"Unknown tool: {name}")

async def main():
    async with mcp.server.stdio.stdio_server() as (read_stream, write_stream):
        await server.run(
            read_stream,
            write_stream,
            InitializationOptions(
                server_name="low-level-server",
                server_version="1.0.0",
                capabilities=server.get_capabilities(
                    notification_options=NotificationOptions(),
                    experimental_capabilities={},
                ),
            ),
        )

if __name__ == "__main__":
    asyncio.run(main())
```

Use the low-level SDK only when FastMCP doesn't support what you need. For >95% of use cases,
FastMCP is the right choice.

---

## 9. Full working example

Complete server that wraps a real open API (no key needed):

```python
#!/usr/bin/env python3
"""Weather MCP server using Open-Meteo (no API key required)."""
import sys
import httpx
from mcp.server.fastmcp import FastMCP, Context

mcp = FastMCP("weather", version="1.0.0")

BASE_URL = "https://api.open-meteo.com/v1"

@mcp.tool()
async def get_forecast(
    latitude: float,
    longitude: float,
    days: int = 7,
    ctx: Context = None,
) -> dict:
    """Get a weather forecast for a geographic location."""
    if not -90 <= latitude <= 90:
        raise ValueError("latitude must be between -90 and 90")
    if not -180 <= longitude <= 180:
        raise ValueError("longitude must be between -180 and 180")
    days = max(1, min(16, days))

    if ctx:
        await ctx.info(f"Fetching {days}-day forecast for ({latitude}, {longitude})")

    params = {
        "latitude": latitude,
        "longitude": longitude,
        "daily": "temperature_2m_max,temperature_2m_min,precipitation_sum,weathercode",
        "forecast_days": days,
        "timezone": "auto",
    }
    async with httpx.AsyncClient() as client:
        res = await client.get(f"{BASE_URL}/forecast", params=params, timeout=15)
        res.raise_for_status()
        return res.json()["daily"]

@mcp.resource("weather://locations/popular")
def popular_locations() -> str:
    """A curated list of popular locations with their coordinates."""
    import json
    locations = [
        {"name": "New York", "lat": 40.71, "lon": -74.01},
        {"name": "London", "lat": 51.51, "lon": -0.13},
        {"name": "Tokyo", "lat": 35.68, "lon": 139.69},
        {"name": "Sydney", "lat": -33.87, "lon": 151.21},
    ]
    return json.dumps(locations, indent=2)

@mcp.prompt()
def weather_briefing(location_name: str, days: int = 3) -> str:
    """Generate a weather briefing request for a location."""
    return (
        f"Please get the {days}-day weather forecast for {location_name} "
        f"and give me a concise briefing suitable for trip planning."
    )

if __name__ == "__main__":
    mcp.run(transport="stdio")
```

Test it:
```bash
mcp dev server.py
uv run python server.py
```