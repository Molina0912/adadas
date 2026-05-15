# MCP Servers Complete Reference

Source: <https://opencode.ai/docs/mcp-servers>

## Overview

MCP (Model Context Protocol) servers provide tools and resources that OpenCode can use. They can be local (running on the machine) or remote (accessed via HTTP).

## MCP Configuration

```json
{
  "mcp": {
    "server-name": {
      "type": "local|remote",
      "command": ["array", "of", "strings"],
      "url": "https://remote.server/mcp",
      "headers": {},
      "env": {},
      "auth": {},
      "enabled": true|false
    }
  }
}
```

## Local MCP Server

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
    },
    "filesystem": {
      "type": "local",
      "command": ["npx", "-y", "@modelcontextprotocol/server-filesystem", "/path/to/dir"],
      "enabled": true
    }
  }
}
```

## Remote MCP Server

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
    },
    "slack": {
      "type": "remote",
      "url": "https://slack.example.com/mcp",
      "headers": {
        "Authorization": "Bearer ${SLACK_TOKEN}"
      },
      "enabled": true
    }
  }
}
```

## MCP with OAuth

```json
{
  "mcp": {
    "sentry": {
      "type": "remote",
      "url": "https://mcp.sentry.dev",
      "auth": {
        "type": "oauth",
        "clientId": "${SENTRY_CLIENT_ID}",
        "clientSecret": "${SENTRY_CLIENT_SECRET}",
        "scopes": ["org:read", "project:releases"]
      },
      "enabled": true
    }
  }
}
```

## MCP with Authorization Header

```json
{
  "mcp": {
    "context7": {
      "type": "remote",
      "url": "https://mcp.context7.com",
      "headers": {
        "Authorization": "Bearer ${CONTEXT7_API_KEY}"
      },
      "enabled": true
    }
  }
}
```

## Popular MCP Servers

### Web Tools
```json
{
  "mcp": {
    "web-tools": {
      "type": "local",
      "command": ["npx", "-y", "@opencodeai/mcp-web-tools"],
      "enabled": true
    }
  }
}
```

### GitHub Integration
```json
{
  "mcp": {
    "github": {
      "type": "remote",
      "url": "https://api.github.com/mcp",
      "headers": {
        "Authorization": "Bearer ${GITHUB_TOKEN}"
      },
      "enabled": true
    }
  }
}
```

### Sentry Error Tracking
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

### Filesystem Access
```json
{
  "mcp": {
    "filesystem": {
      "type": "local",
      "command": ["npx", "-y", "@modelcontextprotocol/server-filesystem", "/home/user/projects"],
      "enabled": true
    }
  }
}
```

### Google Drive
```json
{
  "mcp": {
    "google-drive": {
      "type": "local",
      "command": ["npx", "-y", "@modelcontextprotocol/server-google-drive"],
      "enabled": true
    }
  }
}
```

### Slack
```json
{
  "mcp": {
    "slack": {
      "type": "remote",
      "url": "https://slack.com/api/mcp",
      "headers": {
        "Authorization": "Bearer ${SLACK_BOT_TOKEN}"
      },
      "enabled": true
    }
  }
}
```

## Environment Variable Substitution

Use `${VAR_NAME}` syntax for environment variables:

```json
{
  "mcp": {
    "github": {
      "type": "remote",
      "url": "https://api.github.com/mcp",
      "headers": {
        "Authorization": "Bearer ${GITHUB_TOKEN}",
        "Accept": "${GITHUB_ACCEPT_HEADER}"
      }
    }
  }
}
```

## Disable MCP Server

```json
{
  "mcp": {
    "old-server": {
      "enabled": false
    }
  }
}
```

Or remove from config entirely.

## MCP Commands CLI

```bash
# Add MCP server
opencode mcp add <name> <command-or-url>

# List MCP servers
opencode mcp list

# Authenticate MCP server
opencode mcp auth <name>

# Logout MCP server
opencode mcp logout <name>
```

## MCP Debugging

### Check MCP Status
```bash
opencode mcp list
```

### View MCP Logs
```bash
# Check logs at ~/.config/opencode/logs/
```

### Common Issues

#### MCP Server Not Starting
1. Check command is correct array format
2. Verify package is installed
3. Check environment variables
4. Try running command manually

#### Authentication Failures
1. Verify token environment variables
2. Check OAuth configuration
3. Ensure scopes are correct
4. Try re-authenticating: `opencode mcp auth <name>`

## Per-Agent MCP Configuration

```json
{
  "mcp": {
    "global-mcp": {
      "type": "local",
      "command": ["npx", "-y", "@package/mcp"],
      "enabled": true
    }
  },
  "agent": {
    "my-agent": {
      "mcp": {
        "use": ["global-mcp", "agent-specific-mcp"],
        "disable": ["other-mcp"]
      }
    }
  }
}
```

## MCP Server with Custom Headers

```json
{
  "mcp": {
    "custom-api": {
      "type": "remote",
      "url": "https://api.example.com/mcp",
      "headers": {
        "Authorization": "Bearer ${API_KEY}",
        "X-Custom-Header": "${CUSTOM_VALUE}",
        "Content-Type": "application/json"
      },
      "enabled": true
    }
  }
}
```

## Multiple MCP Servers

```json
{
  "mcp": {
    "web-tools": {
      "type": "local",
      "command": ["npx", "-y", "@opencodeai/mcp-web-tools"],
      "enabled": true
    },
    "github": {
      "type": "remote",
      "url": "https://api.github.com/mcp",
      "headers": {
        "Authorization": "Bearer ${GITHUB_TOKEN}"
      },
      "enabled": true
    },
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

## MCP Type Reference

| Type | Description | Config Required |
|------|-------------|-----------------|
| `local` | Run locally via command | `command` (array) |
| `remote` | Access via URL | `url` (string) |

## MCP Auth Types

### None
```json
{
  "type": "remote",
  "url": "https://public.mcp.server"
}
```

### Bearer Token
```json
{
  "type": "remote",
  "url": "https://api.example.com/mcp",
  "headers": {
    "Authorization": "Bearer ${API_KEY}"
  }
}
```

### OAuth
```json
{
  "type": "remote",
  "url": "https://mcp.example.com",
  "auth": {
    "type": "oauth",
    "clientId": "${OAUTH_CLIENT_ID}",
    "clientSecret": "${OAUTH_CLIENT_SECRET}",
    "scopes": ["read", "write"]
  }
}
```

## Glob Patterns for MCP

```json
{
  "agent": {
    "limited-agent": {
      "mcp": {
        "allowed": ["web-*"],
        "denied": ["github"]
      }
    }
  }
}
```

## MCP Docs (gitmcp.io/docs)

MCP Docs proporciona acceso a documentación técnica desde gitmcp.io/docs.

```json
{
  "mcp": {
    "mcp-docs": {
      "type": "remote",
      "url": "https://gitmcp.io/docs",
      "enabled": true
    }
  }
}
```

### Como USAR:
- Una vez configurado y reiniciado opencode, pregunta al agente sobre temas de documentación
- Es útil para buscar información en documentación de proyectos públicos
- No requiere API key - es un servicio público

### Ejemplo de uso:
```
Usuario: "Busca la documentación de React hooks"
Agente usará mcp-docs para buscar en gitmcp.io/docs
```

---

## Context7 (context7.com)

Context7 es un MCP server que proporciona contexto de código y documentación en tiempo real.

```json
{
  "mcp": {
    "context7": {
      "type": "remote",
      "url": "https://context7.com/mcp",
      "enabled": true
    }
  }
}
```

### Como USAR:
1. **Obtener API Key**: Registrate en <https://context7.com> para obtener tu API key
2. **Configurar**: Añade la variable de entorno `CONTEXT7_API_KEY`
3. **Usar**: El agente consultará contexto de código automáticamente

### Configuración con API Key:
```json
{
  "mcp": {
    "context7": {
      "type": "remote",
      "url": "https://context7.com/mcp",
      "headers": {
        "Authorization": "Bearer ${CONTEXT7_API_KEY}"
      },
      "enabled": true
    }
  }
}
```

### Ejemplo de uso:
```
Usuario: "Explica cómo usar async/await en TypeScript"
Agente usará context7 para obtener contexto actualizado

Usuario: "Dame un ejemplo de REST API con FastAPI"
Context7 provee ejemplos y documentación
```

### Diferencia entre mcp-docs y context7:

| Característica | mcp-docs | context7 |
|---------------|----------|----------|
| URL | `https://gitmcp.io/docs` | `https://context7.com/mcp` |
| API Key | No requerida | Recomendada |
| Tipo | Solo lectura | Contexto de código |
| Uso principal | Documentación general | Documentación técnica con ejemplos |

---

## MCP Health Check

```bash
# Test MCP server is responding
curl -X POST https://your-mcp-server/health \
  -H "Authorization: Bearer ${TOKEN}"
```