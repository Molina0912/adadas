# OpenCode Complete Schema Reference

Source: <https://opencode.ai/config.json>

## Complete opencode.json Schema

```json
{
  "$schema": "https://opencode.ai/config.json",

  // User identity
  "username": "string",
  "color": "#hex-color",

  // Models - Provider/model-id format required
  "model": "anthropic/claude-sonnet-4-6",
  "small_model": "anthropic/claude-haiku-4",

  // Default agent
  "default_agent": "agent-name",

  // Shell configuration
  "shell": "/bin/zsh",
  "shell_args": ["-l"],

  // Logging
  "logLevel": "DEBUG|INFO|WARN|ERROR",
  "logFile": "/path/to/log",

  // Sharing
  "share": "manual|auto|disabled",

  // Auto update
  "autoupdate": true|false|"notify",

  // Snapshot
  "snapshot": true,

  // Instructions files
  "instructions": ["AGENTS.md", "docs/style.md"],

  // Skills configuration
  "skills": {
    "paths": [".opencode/skills", "/abs/path"],
    "urls": ["https://example.com/.well-known/skills/"]
  },

  // Agents - Inline definition
  "agent": {
    "my-agent": {
      "description": "string",
      "mode": "primary|subagent|all",
      "model": "provider/model-id",
      "hidden": true|false,
      "color": "#hex-color",
      "temperature": 0.7,
      "top_p": 0.9,
      "max_steps": 100,
      "permission": {
        "edit": "allow|ask|deny",
        "bash": "allow|ask|deny",
        "read": "allow|ask|deny",
        "glob": "allow|ask|deny",
        "grep": "allow|ask|deny",
        "todowrite": "allow|ask|deny",
        "question": "allow|ask|deny",
        "webfetch": "allow|ask|deny",
        "websearch": "allow|ask|deny"
      },
      "disable": true|false,
      "prompt": "You are..."
    }
  },

  // Commands
  "command": {
    "deploy": {
      "description": "Deploy application",
      "agent": "my-agent",
      "prompt": "Deploy using best practices..."
    },
    "review": {
      "description": "Code review",
      "prompt": "Review code with checklist..."
    }
  },

  // Providers
  "provider": {
    "anthropic": {
      "options": {
        "apiKey": "${ANTHROPIC_API_KEY}",
        "baseURL": "https://api.anthropic.com"
      }
    },
    "openai": {
      "options": {
        "apiKey": "${OPENAI_API_KEY}",
        "baseURL": "https://api.openai.com"
      }
    },
    "google": {
      "options": {
        "apiKey": "${GOOGLE_API_KEY}"
      }
    },
    "deepseek": {
      "options": {
        "apiKey": "${DEEPSEEK_API_KEY}"
      }
    }
  },

  "disabled_providers": ["openai"],
  "enabled_providers": ["anthropic"],

  // MCP Servers
  "mcp": {
    "server-name": {
      "type": "local|remote",
      "command": ["npx", "-y", "@package"],
      "url": "https://remote.server/mcp",
      "headers": {},
      "env": {},
      "enabled": true|false
    }
  },

  // Plugins
  "plugin": [
    "plugin-name",
    "plugin-name@1.0.0",
    "./local-plugin.ts",
    ["plugin-name", { "option": "value" }]
  ],

  // Permissions
  "permission": {
    "edit": "allow|ask|deny",
    "bash": { "pattern": "action" },
    "external_directory": { "~/path/**": "deny" }
  },

  // Formatters
  "formatter": false|{
    "typescript": "prettier",
    "python": "black"
  },

  // LSP
  "lsp": false|{
    "typescript": { "command": "tsserver" }
  },

  // Experimental
  "experimental": {
    "primary_tools": ["edit", "read", "bash"],
    "mcp_timeout": 30000
  },

  // Tool output limits
  "tool_output": {
    "max_lines": 200,
    "max_bytes": 8192
  },

  // Compaction
  "compaction": {
    "auto": true|false,
    "tail_turns": 15
  },

  // TUI
  "tui": {
    "compact": true|false,
    "font_size": 14
  },

  // Theme
  "themes": {
    "selected": "tokyonight|gruvbox|catppuccin|etc",
    "custom": {}
  },

  // Keybinds
  "keybinds": {
    "leader": "ctrl+c",
    "disable_default": ["ctrl+l"]
  }
}
```

## Field Types Detailed

### model (string, required for providers)
Format: `provider/model-id`
Examples:
- `anthropic/claude-sonnet-4-6`
- `anthropic/claude-opus-4`
- `openai/gpt-4-turbo`
- `google/gemini-pro`

### shell (string)
Default: system shell
Options: `/bin/bash`, `/bin/zsh`, `/bin/fish`, `cmd`, `powershell`

### logLevel (enum)
- `DEBUG`: Most verbose
- `INFO`: Default logging
- `WARN`: Warnings only
- `ERROR`: Errors only

### share (enum)
- `manual`: Default, share via command
- `auto`: Auto-share all sessions
- `disabled`: No sharing

### autoupdate (enum|boolean)
- `true`: Auto update
- `false`: No auto update
- `"notify"`: Notify but don't auto update

### mode (enum for agents)
- `primary`: Main agent for tasks
- `subagent`: Task-specific agent
- `all`: All modes enabled

### permission action (enum)
- `allow`: Permitir sin confirmación
- `ask`: Confirmar antes de ejecutar
- `deny`: Bloquear completamente

### temperature (number)
Range: 0.0 - 1.0
Default: 0.7
Lower = more deterministic

### top_p (number)
Range: 0.0 - 1.0
Default: 0.9
Nucleus sampling parameter

### max_steps (number)
Maximum steps before stopping
Default: unlimited

## Config Precedence Order

1. `OPENCODE_CONFIG_CONTENT` env var
2. `OPENCODE_CONFIG` env var path
3. `./opencode.json` (project)
4. `./opencode.jsonc`
5. `.opencode/opencode.json`
6. `~/.config/opencode/opencode.json` (global)

## Escape Hatches

```bash
# Skip project config
OPENCODE_DISABLE_PROJECT_CONFIG=1 opencode

# Custom config path
OPENCODE_CONFIG=/path/to/config.json opencode

# Inline config
OPENCODE_CONFIG_CONTENT='{"model":"anthropic/claude-sonnet-4-6"}' opencode

# Skip plugins
OPENCODE_PURE=1 opencode

# Skip external skills
OPENCODE_DISABLE_EXTERNAL_SKILLS=1 opencode
OPENCODE_DISABLE_CLAUDE_CODE_SKILLS=1 opencode
```

## Validation Rules

- Unknown top-level keys rejected with ConfigInvalidError
- model must include provider prefix (e.g., "anthropic/claude-sonnet-4-6")
- skills.paths is an array, not a string
- agent is an object keyed by name, not an array
- plugin is an array of strings or [name, options] tuples
- mcp[name].command is an array of strings, never a single string
- mcp[name].type is required

## Provider Options by Provider

### Anthropic
```json
{
  "provider": {
    "anthropic": {
      "options": {
        "apiKey": "${ANTHROPIC_API_KEY}",
        "baseURL": "https://api.anthropic.com",
        "maxTokens": 8192
      }
    }
  }
}
```

### OpenAI
```json
{
  "provider": {
    "openai": {
      "options": {
        "apiKey": "${OPENAI_API_KEY}",
        "baseURL": "https://api.openai.com/v1",
        "organization": "${OPENAI_ORG}"
      }
    }
  }
}
```

### Google
```json
{
  "provider": {
    "google": {
      "options": {
        "apiKey": "${GOOGLE_API_KEY}",
        "baseURL": "https://generativelanguage.googleapis.com"
      }
    }
  }
}
```

### Amazon Bedrock
```json
{
  "provider": {
    "amazon-bedrock": {
      "options": {
        "region": "us-east-1",
        "accessKeyId": "${AWS_ACCESS_KEY_ID}",
        "secretAccessKey": "${AWS_SECRET_ACCESS_KEY}"
      }
    }
  }
}
```

### DeepSeek
```json
{
  "provider": {
    "deepseek": {
      "options": {
        "apiKey": "${DEEPSEEK_API_KEY}",
        "baseURL": "https://api.deepseek.com"
      }
    }
  }
}
```

## MCP Server Examples

### Local MCP
```json
{
  "mcp": {
    "playwright": {
      "type": "local",
      "command": ["npx", "-y", "@playwright/mcp"],
      "env": {
        "BROWSER": "chromium"
      },
      "enabled": true
    }
  }
}
```

### Remote MCP with headers
```json
{
  "mcp": {
    "github": {
      "type": "remote",
      "url": "https://api.github.com/mcp",
      "headers": {
        "Authorization": "Bearer ${GITHUB_TOKEN}",
        "Accept": "application/vnd.github+json"
      },
      "enabled": true
    }
  }
}
```

### Remote MCP with OAuth
```json
{
  "mcp": {
    "sentry": {
      "type": "remote",
      "url": "https://mcp.sentry.dev",
      "auth": {
        "type": "oauth",
        "clientId": "${SENTRY_CLIENT_ID}",
        "clientSecret": "${SENTRY_CLIENT_SECRET}"
      },
      "enabled": true
    }
  }
}
```

## Plugin Examples

### NPM Package
```json
{
  "plugin": [
    "opencode-gemini-auth",
    "opencode-sentry-monitor@1.2.3"
  ]
}
```

### Local File
```json
{
  "plugin": [
    "./plugins/my-plugin.ts",
    "/abs/path/to/plugin.js"
  ]
}
```

### With Options
```json
{
  "plugin": [
    ["opencode-notificator", {
      "channels": ["slack", "discord"],
      "silent": false
    }]
  ]
}
```

## Permissions Pattern Examples

### Simple - Allow all
```json
{
  "permission": {
    "edit": "allow",
    "bash": "allow"
  }
}
```

### Pattern-based
```json
{
  "permission": {
    "edit": "allow",
    "bash": {
      "git *": "allow",
      "npm *": "allow",
      "docker *": "allow",
      "rm *": "deny",
      "*": "ask"
    },
    "external_directory": {
      "~/secrets/**": "deny",
      "~/projects/**": "allow",
      "*": "ask"
    }
  }
}
```

## Complete Example opencode.json

```json
{
  "$schema": "https://opencode.ai/config.json",
  "username": "developer",
  "model": "anthropic/claude-sonnet-4-6",
  "small_model": "anthropic/claude-haiku-4",
  "default_agent": "zero-errors",
  "shell": "/bin/zsh",
  "logLevel": "INFO",
  "share": "manual",
  "autoupdate": "notify",
  "snapshot": true,
  "instructions": ["AGENTS.md"],

  "skills": {
    "paths": [".opencode/skills", "~/.config/opencode/skills"],
    "urls": []
  },

  "agent": {
    "zero-errors": {
      "description": "Zero errors code quality agent",
      "mode": "primary",
      "model": "anthropic/claude-sonnet-4-6",
      "permission": {
        "edit": "allow",
        "bash": "ask",
        "read": "allow"
      },
      "temperature": 0.3
    },
    "code-review": {
      "description": "Code review specialized agent",
      "mode": "subagent",
      "model": "anthropic/claude-sonnet-4-6",
      "permission": {
        "edit": "ask",
        "bash": "ask",
        "read": "allow"
      }
    }
  },

  "command": {
    "deploy": {
      "description": "Deploy application",
      "agent": "zero-errors",
      "prompt": "Deploy following best practices: 1) Verify tests, 2) Build, 3) Deploy to staging, 4) Verify, 5) Deploy to production"
    },
    "review": {
      "description": "Code review command",
      "prompt": "Review code using anti-spaghetti checklist"
    }
  },

  "provider": {
    "anthropic": {
      "options": {
        "apiKey": "${ANTHROPIC_API_KEY}"
      }
    }
  },

  "mcp": {
    "web-tools": {
      "type": "local",
      "command": ["npx", "-y", "@opencodeai/web-tools-mcp"],
      "enabled": true
    }
  },

  "plugin": [
    "opencode-sentry-monitor"
  ],

  "permission": {
    "edit": "allow",
    "bash": {
      "git *": "allow",
      "npm *": "allow",
      "*": "ask"
    }
  },

  "formatter": true,
  "lsp": true,

  "compaction": {
    "auto": true,
    "tail_turns": 15
  }
}
```