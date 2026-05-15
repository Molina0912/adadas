---
name: opencode-mastery
description: |
  Domina OpenCode al 100%. USA ESTE SKILL cuando el usuario quiera:
  - CONFIGURAR OpenCode (opencode.json, agents, skills, commands, plugins)
  - MCP SERVERS - web tools, github, sentry, filesystem
  - PROVIDERS - anthropic, openai, google, deepseek, bedrock
  - PERMISOS - security, permissions, bash, edit controls
  - THEMES - tokyonight, gruvbox, catppuccin, custom themes
  - TUI/CLI - terminal UI, keybinds, commands
  - DEPLOY - enterprise, self-hosting, docker, kubernetes
  - TROUBLESHOOTING - errors, debugging, performance

  Especializado en <https://opencode.ai/docs/> con las 36 páginas:
  Agents, Skills, Commands, Plugins, MCP, Providers, Models, Themes,
  Permissions, TUI, CLI, Server, Enterprise, GitHub, GitLab, ACP,
  Web, Network, Zen, Go, LSP, Formatters, Rules, IDE, SDK, Ecosystem

  USA ESTE SKILL para CUALQUIER cosa relacionada con OpenCode.
  Incluye TOODO el schema completo, ejemplos funcionales y reference files detallados.
---

# OpenCode Mastery - Domina OpenCode al 100%

Este skill te convierte en un experto de OpenCode con acceso a TODA la documentación.

## 📚 Reference Files (LEER cuando necesites detalles)

| Reference | Descripción |
|-----------|-------------|
| `reference/config-schema.md` | Schema completo JSON con todos los campos |
| `reference/agents.md` | Agents: built-in, custom, modes, permissions |
| `reference/skills.md` | Skills: crear, cargar, discovery, ejemplos |
| `reference/commands.md` | Commands: crear, argumentos, encadenar |
| `reference/plugins.md` | Plugins: hooks, eventos, ejemplos TypeScript |
| `reference/mcp-servers.md` | MCP: local, remote, OAuth, auth headers, **mcp-docs, context7** |
| `reference/tui-cli-keys.md` | TUI, CLI, keybinds, todos los comandos |
| `reference/providers-models.md` | Providers: anthropic, openai, google, bedrock |
| `reference/permissions.md` | Permissions: allow/ask/deny, patrones |
| `reference/themes-formatters-lsp.md` | Themes, formatters, LSP setup |
| `reference/troubleshooting.md` | Errors, debugging, common issues |
| `reference/integrations.md` | GitHub, GitLab, ACP, Zed, JetBrains |
| `reference/enterprise-deployment.md` | Enterprise, server, docker, kubernetes |

## 🎯 Filosofía OpenCode

1. **Config es strict** - Validado contra JSON Schema, guardar y reiniciar
2. **Estructura por archivos** - Agents, skills, commands en archivos separados
3. **Providers** - Modelo siempre con prefijo `provider/model-id`
4. **Permisos granulares** - allow/ask/deny por tool y patrón
5. **Plugins extensible** - Hooks para cada evento
6. **MCP universal** - Local o remote servers

## ⚡ Configuración Rápica

### opencode.json mínimo

```json
{
  "$schema": "https://opencode.ai/config.json",
  "model": "anthropic/claude-sonnet-4-6",
  "default_agent": "zero-errors"
}
```

### Providers principales

```json
{
  "provider": {
    "anthropic": { "options": { "apiKey": "${ANTHROPIC_API_KEY}" } },
    "openai": { "options": { "apiKey": "${OPENAI_API_KEY}" } },
    "google": { "options": { "apiKey": "${GOOGLE_API_KEY}" } },
    "deepseek": { "options": { "apiKey": "${DEEPSEEK_API_KEY}" } }
  }
}
```

### MCP web-tools

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

## 📁 Estructura de Archivos

| Scope | Path |
|-------|------|
| Project config | `./opencode.json`, `.opencode/opencode.json` |
| Global config | `~/.config/opencode/opencode.json` |
| Project agents | `.opencode/agent/<name>.md`, `.opencode/agents/<name>.md` |
| Global agents | `~/.config/opencode/agent/<name>.md` |
| Project skills | `.opencode/skill/<name>/SKILL.md` |
| Global skills | `~/.config/opencode/skill/<name>/SKILL.md` |
| Auto plugins | `.opencode/plugin/*.ts`, `.opencode/plugins/*.ts` |

## 🤖 Agents

### Built-in agents

| Agent | Propósito | Mode |
|-------|-----------|------|
| `build` | Construir código | primary |
| `plan` | Planificación | primary |
| `general` | Tareas generales | all |
| `explore` | Explorar codebases | subagent |
| `scout` | Búsqueda (experimental) | subagent |

### Crear agent

```markdown
<!-- .opencode/agent/zero-errors.md -->
---
name: zero-errors
description: Agente experto en código sin errores
mode: primary
model: anthropic/claude-sonnet-4-6
permission:
  edit: allow
  bash: ask
temperature: 0.3
---

Eres un experto en calidad de código...
```

## 🎓 Skills

### Crear skill

```markdown
<!-- .opencode/skill/my-skill/SKILL.md -->
---
name: my-skill
description: |
  USA ESTE SKILL cuando: trigger keywords
  Hace: descripción de lo que hace
---

# My Skill

## Instructions...
```

## ⌨️ Commands

```json
{
  "command": {
    "deploy": {
      "description": "Deploy aplicación",
      "prompt": "Deploy siguiendo best practices..."
    }
  }
}
```

## 🔌 Plugins

```typescript
// .opencode/plugin/my-plugin.ts
import type { Plugin } from "@opencode-ai/plugin"

export default (async ({ client }) => {
  return {
    "tool.execute.after": async (input, output) => {
      // Custom logic
    }
  }
}) satisfies Plugin
```

## 🛡️ Permissions

```json
{
  "permission": {
    "edit": "allow",
    "bash": {
      "git *": "allow",
      "rm *": "deny",
      "*": "ask"
    }
  }
}
```

## 📋 Quick Reference

```json
{
  "$schema": "https://opencode.ai/config.json",
  "model": "provider/model-id",
  "default_agent": "agent-name",
  "shell": "/bin/zsh",
  "logLevel": "DEBUG|INFO|WARN|ERROR",
  "share": "manual|auto|disabled",
  "autoupdate": true,
  "instructions": ["AGENTS.md"],
  "skills": { "paths": [], "urls": [] },
  "agent": {},
  "command": {},
  "provider": {},
  "mcp": {},
  "plugin": [],
  "permission": {},
  "formatter": false,
  "lsp": false
}
```

## 🚀 Comandos CLI

```bash
opencode --help              # Ayuda
opencode auth login          # Login providers
opencode models list         # Listar modelos
opencode mcp add <name> <cmd> # Añadir MCP
opencode agent create <name> # Crear agent
opencode session list        # Listar sesiones
opencode serve --port 4096   # Server mode
opencode web --port 8080     # Web interface
```

## 🌍 Environment Variables

| Variable | Propósito |
|----------|----------|
| `OPENCODE_DISABLE_PROJECT_CONFIG=1` | Skip project config |
| `OPENCODE_CONFIG=/path/config.json` | Custom config path |
| `OPENCODE_CONFIG_CONTENT='{...}'` | Inline config JSON |
| `OPENCODE_PURE=1` | Skip all plugins |
| `OPENCODE_DISABLE_EXTERNAL_SKILLS=1` | Skip external skills |
| `ANTHROPIC_API_KEY` | API key Anthropic |
| `OPENAI_API_KEY` | API key OpenAI |

## 📚 Docs URLs

| Tema | URL |
|------|-----|
| Docs home | <https://opencode.ai/docs/> |
| Config | <https://opencode.ai/docs/config> |
| Agents | <https://opencode.ai/docs/agents> |
| Skills | <https://opencode.ai/docs/skills> |
| MCP | <https://opencode.ai/docs/mcp-servers> |
| Providers | <https://opencode.ai/docs/providers> |
| Schema | <https://opencode.ai/config.json> |

## ✅ Best Practices

1. **SIEMPRE** usar `$schema` en opencode.json
2. **SIEMPRE** guardar y reiniciar tras cambios de config
3. **SIEMPRE** preferir archivos sobre config inline
4. **SIEMPRE** usar env vars para API keys
5. **NUNCA** hardcodear credenciales
6. **NUNCA** crear archivos prohibited (utils.ts, helpers.ts, manager.ts)

## 🚨 Reglas Críticas

- `model` siempre `provider/model-id` (ej: `anthropic/claude-sonnet-4-6`)
- `skills.paths` es array, no string
- `agent` es object keyed por nombre, no array
- `plugin` es array de strings o [name, options] tuples
- `mcp[name].command` es array de strings, nunca string único
- `mcp[name].type` es requerido (local|remote)
- Project config override global config

## 🆘 Troubleshooting

1. **OpenCode no inicia**: Usar `OPENCODE_DISABLE_PROJECT_CONFIG=1`
2. **Auth issues**: `opencode auth login` y verificar API keys
3. **MCP no funciona**: Verificar command array format y logs
4. **Plugin error**: Check `.ts` syntax con `npx tsc --noEmit`

## 🎯 Como USAR este skill

Cuando el usuario pida algo de OpenCode:

1. **IDENTIFICAR** qué necesita (config, agent, skill, plugin, MCP, etc)
2. **LEER** el reference file correspondiente para detalles completos
3. **IMPLEMENTAR** con ejemplos funcionales del reference
4. **EXPLICAR** структуру y próximos pasos

---

**Documentación completa:** <https://opencode.ai/docs/>
**Schema completo:** <https://opencode.ai/config.json>
**Reference files:** `~/.config/opencode/skills/opencode-mastery/reference/`