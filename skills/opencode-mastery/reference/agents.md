# Agents Complete Reference

Source: <https://opencode.ai/docs/agents>

## Overview

Agents are specialized AI assistants configured in OpenCode. They can be:
- **Primary**: Main agent for general tasks
- **Subagent**: Specialized for specific tasks
- **All**: All modes enabled

## Agent File Structure

### Location
- Project: `.opencode/agent/<name>.md` or `.opencode/agents/<name>.md`
- Global: `~/.config/opencode/agent/<name>.md` or `~/.config/opencode/agents/<name>.md`

### Frontmatter Fields

| Field | Type | Description |
|-------|------|-------------|
| `name` | string | Agent identifier (optional in file form) |
| `description` | string | What the agent does |
| `mode` | enum | `primary`, `subagent`, `all` |
| `model` | string | Provider/model-id format |
| `hidden` | boolean | Hide from agent list |
| `color` | string | Hex color for UI |
| `temperature` | number | 0.0-1.0 (default 0.7) |
| `top_p` | number | Nucleus sampling (default 0.9) |
| `max_steps` | number | Max steps before stop |
| `permission` | object | Permission overrides |
| `disable` | boolean | Disable built-in agent |
| `steps` | number | Execution steps |

### Example Agent File

```markdown
---
description: Security-focused code reviewer that checks for OWASP vulnerabilities
mode: subagent
model: anthropic/claude-sonnet-4-6
color: "#ff0000"
temperature: 0.3
permission:
  edit: ask
  bash: deny
  read: allow
---

You are a security-focused code reviewer. You check every code change for:
1. OWASP Top 10 vulnerabilities
2. SQL injection risks
3. XSS vulnerabilities
4. Hardcoded credentials
5. Input validation issues

When reviewing:
1. Read the file completely
2. Run security checks
3. Report vulnerabilities with severity
4. Suggest fixes with code examples
```

## Built-in Agents

### build
Main agent for implementing code.
```markdown
---
description: Build and implement code solutions
mode: primary
model: anthropic/claude-sonnet-4-6
---

You are a code implementation agent. You build solutions following best practices.
```

### plan
Planning and analysis agent.
```markdown
---
description: Analyze requirements and create implementation plans
mode: primary
---

You plan and analyze before implementing. Break down complex tasks into steps.
```

### general
General purpose agent.
```markdown
---
description: General task execution agent
mode: all
---

Handle general tasks efficiently.
```

### explore
Codebase exploration agent.
```markdown
---
description: Explore and understand codebases
mode: subagent
---

Explore code, find patterns, understand architecture.
```

### scout (experimental)
Requires `OPENCODE_EXPERIMENTAL_SCOUT=1`
```markdown
---
description: Advanced search and discovery
mode: subagent
---

Advanced search across codebases.
```

### Hidden Agents
- `compaction`: Session compaction
- `title`: Conversation titling
- `summary`: Conversation summarization

## Agent Modes Deep Dive

### Primary Mode
Used for main tasks. Default mode for most work.
```markdown
---
mode: primary
model: anthropic/claude-sonnet-4-6
---

Handles main task execution and coordination.
```

### Subagent Mode
Specialized for specific domains.
```markdown
---
mode: subagent
model: anthropic/claude-sonnet-4-6
description: Database optimization specialist
---

Specialist for database queries and optimization.
```

### All Mode
All capabilities enabled.
```markdown
---
mode: all
---

Flexible agent for any task.
```

## Agent Configuration in opencode.json

```json
{
  "agent": {
    "my-agent": {
      "description": "My custom agent",
      "mode": "subagent",
      "model": "anthropic/claude-sonnet-4-6",
      "hidden": false,
      "color": "#00ff00",
      "temperature": 0.5,
      "top_p": 0.8,
      "max_steps": 50,
      "permission": {
        "edit": "allow",
        "bash": "ask"
      },
      "disable": false
    }
  }
}
```

## Override Built-in Agents

```markdown
---
name: build
description: Enhanced build agent with security focus
mode: primary
model: anthropic/claude-sonnet-4-6
permission:
  edit: allow
  bash: "ask"
---

You are an enhanced build agent...
```

Or in config:
```json
{
  "agent": {
    "build": {
      "description": "Enhanced build",
      "temperature": 0.5
    }
  }
}
```

## Agent Permissions

Permission object supports:
- `edit`: File editing
- `bash`: Shell commands
- `read`: File reading
- `glob`: File globbing
- `grep`: Content search
- `todowrite`: Todo management
- `question`: Ask user
- `webfetch`: Fetch web content
- `websearch`: Web search

## Temperature Guidelines

| Task | Temperature |
|------|-------------|
| Code generation | 0.2-0.4 |
| Creative writing | 0.7-0.9 |
| Analysis | 0.3-0.5 |
| Summarization | 0.2-0.4 |
| Q&A | 0.2-0.3 |

## Max Steps Guidelines

| Task Complexity | Max Steps |
|----------------|-----------|
| Simple (1-2 files) | 20 |
| Medium (3-5 files) | 50 |
| Complex (5+ files) | 100 |
| Very Complex | unlimited |

## Agent Chaining

Create specialized agents and chain them:
```markdown
# In main agent prompt

When the user asks for database work:
1. Use the `db-expert` subagent for schema design
2. Use the `db-reviewer` subagent for review
3. Use the `build` agent for implementation
```