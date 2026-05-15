# TUI, CLI, and Keybinds Complete Reference

Source: <https://opencode.ai/docs/tui>, <https://opencode.ai/docs/cli>, <https://opencode.ai/docs/keybinds>

## TUI (Terminal User Interface)

### TUI Commands

| Command | Description |
|---------|-------------|
| `/connect` | Connect to a server |
| `/compact` | Compact current session |
| `/details` | Show session details |
| `/editor` | Open in editor |
| `/exit` | Exit OpenCode |
| `/export` | Export session |
| `/help` | Show help |
| `/init` | Initialize new session |
| `/models` | List available models |
| `/new` | Start new conversation |
| `/redo` | Redo last action |
| `/sessions` | Manage sessions |
| `/share` | Share current session |
| `/themes` | Change theme |
| `/thinking` | Toggle thinking display |
| `/undo` | Undo last action |
| `/unshare` | Stop sharing session |

### TUI Navigation

| Key | Action |
|-----|--------|
| `↑/↓` | Navigate history |
| `Ctrl+C` | Cancel current operation |
| `Ctrl+L` | Clear screen |
| `Ctrl+Z` | Suspend process |
| `Tab` | Autocomplete |
| `Enter` | Execute |

### Editor Setup

#### Linux/macOS

Add to `~/.bashrc` or `~/.zshrc`:
```bash
export EDITOR=vim  # or nano, code, etc.
```

Or configure in opencode.json:
```json
{
  "tui": {
    "editor": "vim"
  }
}
```

#### Windows (CMD)
```cmd
set EDITOR=vim
```

#### Windows (PowerShell)
```powershell
$env:EDITOR = "vim"
```

### TUI Options

```json
{
  "tui": {
    "compact": true,
    "font_size": 14,
    "editor": "vim"
  }
}
```

## CLI (Command Line Interface)

### Global Flags

| Flag | Description |
|------|-------------|
| `--help, -h` | Show help |
| `--version, -v` | Show version |
| `--config <path>` | Custom config path |
| `--model <model>` | Specify model |
| `--debug` | Debug mode |

### CLI Commands

#### `opencode agent`

```bash
# Create new agent
opencode agent create <name>

# List agents
opencode agent list

# Attach to agent
opencode agent attach <name>
```

##### `opencode agent create`

```bash
opencode agent create my-agent --description "My custom agent"
```

##### `opencode agent list`

```bash
opencode agent list
# Output:
# build     - Build and implement code
# plan      - Planning and analysis
# general   - General tasks
# explore   - Explore codebases
# my-agent  - My custom agent
```

#### `opencode auth`

```bash
# Login
opencode auth login

# List auth
opencode auth list

# Logout
opencode auth logout <provider>
```

##### Auth Providers

```bash
# Anthropic
opencode auth login anthropic

# OpenAI
opencode auth login openai

# Google
opencode auth login google
```

#### `opencode github`

```bash
# Install GitHub app
opencode github install

# Check status
opencode github status
```

#### `opencode mcp`

```bash
# Add MCP server
opencode mcp add <name> <command-or-url>

# List MCP servers
opencode mcp list

# Authenticate
opencode mcp auth <name>

# Logout
opencode mcp logout <name>
```

##### Examples

```bash
# Add local MCP
opencode mcp add web-tools "npx -y @opencodeai/mcp-web-tools"

# Add remote MCP
opencode mcp add github "https://api.github.com/mcp"

# List all
opencode mcp list
```

#### `opencode models`

```bash
# List available models
opencode models list

# Run with specific model
opencode run --model anthropic/claude-opus-4
```

#### `opencode run`

```bash
# Run with options
opencode run --model <model> --timeout 300

# Run with context
opencode run --context ./project --model anthropic/claude-sonnet-4-6
```

#### `opencode serve`

```bash
# Start server
opencode serve --port 4096

# Start with auth
opencode serve --port 4096 --auth

# Start with CORS
opencode serve --port 4096 --cors
```

##### Serve Options

| Option | Description | Default |
|--------|-------------|---------|
| `--port` | Server port | 4096 |
| `--hostname` | Server hostname | localhost |
| `--auth` | Enable authentication | false |
| `--cors` | Enable CORS | false |

#### `opencode session`

```bash
# List sessions
opencode session list

# Delete session
opencode session delete <session-id>

# Export session
opencode session export <session-id>

# Stats
opencode session stats
```

##### Examples

```bash
# List all sessions
opencode session list

# Export session
opencode session export abc123

# Session stats
opencode session stats
# Output:
# Total sessions: 12
# Total messages: 847
# Average session length: 70 messages
```

#### `opencode web`

```bash
# Start web interface
opencode web

# Custom port
opencode web --port 8080

# Custom hostname
opencode web --hostname 0.0.0.0
```

### CLI Environment Variables

| Variable | Description |
|----------|-------------|
| `OPENCODE_CONFIG` | Config file path |
| `OPENCODE_CONFIG_CONTENT` | Inline config JSON |
| `OPENCODE_DISABLE_PROJECT_CONFIG` | Skip project config |
| `OPENCODE_PURE` | Skip all plugins |
| `OPENCODE_DISABLE_EXTERNAL_SKILLS` | Skip external skills |
| `ANTHROPIC_API_KEY` | Anthropic API key |
| `OPENAI_API_KEY` | OpenAI API key |
| `GOOGLE_API_KEY` | Google API key |

## Keybinds

### Leader Key

Default leader key is `Ctrl+C` (configurable).

### Binding Values

| Value | Description |
|-------|-------------|
| `ctrl+c` | Ctrl key + C |
| `alt+x` | Alt key + X |
| `shift+enter` | Shift + Enter |
| `ctrl+shift+t` | Ctrl + Shift + T |
| `cmd+s` | Command + S (Mac) |
| `super+k` | Super + K |

### Disable Keybind

```json
{
  "keybinds": {
    "disable_default": ["ctrl+l", "ctrl+c"]
  }
}
```

### Custom Keybinds

```json
{
  "keybinds": {
    "leader": "ctrl+c",
    "custom": {
      "ctrl+shift+n": "new-session",
      "ctrl+shift+e": "export-session",
      "alt+t": "toggle-theme"
    }
  }
}
```

### Desktop Prompt Shortcuts

#### Shift+Enter

Send message without executing tools (prompt only).

```json
{
  "keybinds": {
    "desktop_prompt_shortcut": "shift+enter"
  }
}
```

### Windows Terminal Keybinds

Add to Windows Terminal settings.json:
```json
{
  "keybindings": [
    {
      "command": "sendInput",
      "keys": "ctrl+shift+c",
      "input": "\u0003"  // Ctrl+C
    }
  ]
}
```

## TUI Customization

### Username Display

```json
{
  "tui": {
    "username_display": "full|short|disabled"
  }
}
```

### Theme Selection

```json
{
  "tui": {
    "theme": "tokyonight"
  }
}
```

### Font Size

```json
{
  "tui": {
    "font_size": 14
  }
}
```

## Command Reference Quick Guide

```bash
# Quick Reference
opencode                          # Start OpenCode
opencode --help                   # Show help
opencode --version                # Show version
opencode --model <model>          # Run with model

# Agent Management
opencode agent create <name>      # Create agent
opencode agent list               # List agents
opencode agent attach <name>      # Attach to agent

# Auth Management
opencode auth login               # Login
opencode auth list                # List auth
opencode auth logout <provider>   # Logout

# MCP Management
opencode mcp add <name> <cmd>     # Add MCP
opencode mcp list                 # List MCPs
opencode mcp auth <name>          # Auth MCP
opencode mcp logout <name>        # Logout MCP

# Session Management
opencode session list             # List sessions
opencode session delete <id>      # Delete session
opencode session export <id>      # Export session
opencode session stats            # Session stats

# Server
opencode serve --port 4096        # Start server
opencode serve --auth             # With auth
opencode serve --cors             # With CORS

# Web
opencode web                      # Start web UI
opencode web --port 8080          # Custom port

# GitHub
opencode github install           # Install GitHub app

# Models
opencode models list              # List models
opencode run --model <model>      # Run with model
```