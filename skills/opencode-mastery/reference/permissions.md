# Permissions Complete Reference

Source: <https://opencode.ai/docs/permissions>

## Overview

Permissions control which actions require approval to run. They can be set at the global level or per-agent.

## Permission Structure

```json
{
  "permission": {
    "edit": "allow|ask|deny",
    "bash": "allow|ask|deny",
    "read": "allow|ask|deny",
    "glob": "allow|ask|deny",
    "grep": "allow|ask|deny",
    "todowrite": "allow|ask|deny",
    "question": "allow|ask|deny",
    "webfetch": "allow|ask|deny",
    "websearch": "allow|ask|deny",
    "external_directory": { "pattern": "action" }
  }
}
```

## Permission Actions

| Action | Description |
|--------|-------------|
| `allow` | Permit immediately without confirmation |
| `ask` | Confirm before executing |
| `deny` | Block execution |

## Permission Tools

| Tool | Description |
|------|-------------|
| `read` | Read files |
| `edit` | Edit files |
| `glob` | Find files by pattern |
| `grep` | Search file contents |
| `bash` | Execute shell commands |
| `task` | Run subagent tasks |
| `todowrite` | Manage todo list |
| `question` | Ask user questions |
| `webfetch` | Fetch web content |
| `websearch` | Search the web |
| `external_directory` | Access external directories |
| `lsp` | Language server protocol |
| `doom_loop` | Loop detection |
| `skill` | Use skills |
| `repo_clone` | Clone repositories |
| `repo_overview` | Repository overview |

## Simple Permissions

### Allow All
```json
{
  "permission": {
    "edit": "allow",
    "bash": "allow"
  }
}
```

### Ask All
```json
{
  "permission": {
    "edit": "ask",
    "bash": "ask",
    "read": "ask"
  }
}
```

### Deny Dangerous
```json
{
  "permission": {
    "edit": "allow",
    "bash": "ask",
    "rm *": "deny",
    "format *": "allow"
  }
}
```

## Pattern-Based Permissions

```json
{
  "permission": {
    "bash": {
      "git *": "allow",
      "npm *": "allow",
      "docker *": "allow",
      "rm *": "deny",
      "rm -rf /*": "deny",
      "*": "ask"
    },
    "edit": {
      "src/**": "allow",
      "tests/**": "allow",
      "*.md": "allow",
      "secrets/**": "deny",
      "*": "ask"
    },
    "external_directory": {
      "~/secrets/**": "deny",
      "~/projects/**": "allow",
      "/tmp/**": "allow",
      "*": "ask"
    }
  }
}
```

## Per-Agent Permissions

```json
{
  "agent": {
    "build": {
      "description": "Build agent",
      "permission": {
        "edit": "allow",
        "bash": { "git *": "allow", "npm *": "allow", "*": "ask" },
        "read": "allow"
      }
    },
    "review": {
      "description": "Review agent",
      "permission": {
        "edit": "ask",
        "bash": "deny",
        "read": "allow"
      }
    },
    "explorer": {
      "description": "Explorer agent",
      "permission": {
        "edit": "deny",
        "bash": "deny",
        "read": "allow",
        "glob": "allow",
        "grep": "allow"
      }
    }
  }
}
```

## Override Built-in Agents

```markdown
<!-- .opencode/agent/build.md -->
---
description: Build with security restrictions
permission:
  edit: allow
  bash:
    git *: allow
    npm *: allow
    docker *: allow
    rm *: deny
    *: ask
---

Build agent with restricted shell access.
```

## External Directory Permissions

```json
{
  "permission": {
    "external_directory": {
      "~/secrets/**": "deny",
      "~/keys/**": "deny",
      "~/projects/**": "allow",
      "/etc/secrets/**": "deny",
      "*": "ask"
    }
  }
}
```

## Special Permission Keys

### doom_loop
Prevents infinite loops (flat action only):
```json
{
  "permission": {
    "doom_loop": "deny"
  }
}
```

### todowrite
Todo list operations (flat action only):
```json
{
  "permission": {
    "todowrite": "ask"
  }
}
```

### question
Ask user questions (flat action only):
```json
{
  "permission": {
    "question": "ask"
  }
}
```

### webfetch
Fetch web content:
```json
{
  "permission": {
    "webfetch": "ask"
  }
}
```

### websearch
Web search:
```json
{
  "permission": {
    "websearch": "ask"
  }
}
```

## Rule Evaluation Order

Rules are evaluated in **insertion order**. The **last matching rule wins**.

### Correct Order Example
```json
{
  "bash": {
    "rm *": "deny",      // Specific deny first
    "git *": "allow",     // Specific allow
    "npm *": "allow",     // Specific allow
    "*": "ask"            // Default ask last
  }
}
```

### Wrong Order Example
```json
{
  "bash": {
    "*": "ask",           // Default first (matches everything!)
    "git *": "allow",     // Never reached
    "rm *": "deny"        // Never reached
  }
}
```

## Granular Rules (Object Syntax)

```json
{
  "permission": {
    "edit": {
      "*.ts": "allow",
      "*.js": "allow",
      "secrets.json": "deny",
      "*": "ask"
    },
    "bash": {
      "git status": "allow",
      "git commit *": "allow",
      "npm test": "allow",
      "rm -rf *": "deny",
      "*": "ask"
    }
  }
}
```

## Home Directory Expansion

`~` is expanded to the user's home directory:
```json
{
  "permission": {
    "external_directory": {
      "~/secrets/**": "deny",
      "~/projects/**": "allow"
    }
  }
}
```

## Defaults

Default permissions if not specified:
```json
{
  "permission": {
    "edit": "ask",
    "read": "allow",
    "glob": "allow",
    "grep": "allow",
    "bash": "ask",
    "todowrite": "ask",
    "question": "ask"
  }
}
```

## Permission Escalation

Agents cannot escalate their own permissions. If an agent has `deny`, it cannot change to `allow`.

## Plan Mode Permissions

Plan Mode uses the `plan` agent's permission ruleset:
```json
{
  "agent": {
    "plan": {
      "permission": {
        "edit": "deny",
        "bash": "deny",
        "read": "allow"
      }
    }
  }
}
```

## Testing Permissions

Test with dry-run:
```bash
opencode run --permission-check
```

## Permission Debugging

Check permission logs:
```bash
# View logs at ~/.config/opencode/logs/
```

## Common Patterns

### Development Machine
```json
{
  "permission": {
    "edit": "allow",
    "bash": {
      "git *": "allow",
      "npm *": "allow",
      "docker *": "allow",
      "python *": "allow",
      "rm *": "ask",
      "*": "ask"
    },
    "external_directory": "allow"
  }
}
```

### Production Server
```json
{
  "permission": {
    "edit": "ask",
    "bash": {
      "git *": "allow",
      "docker *": "allow",
      "pm2 *": "allow",
      "rm *": "deny",
      "*": "deny"
    },
    "external_directory": {
      "~/projects/**": "allow",
      "*": "ask"
    }
  }
}
```

### Read-Only Mode
```json
{
  "permission": {
    "edit": "deny",
    "bash": "deny",
    "read": "allow",
    "glob": "allow",
    "grep": "allow"
  }
}
```