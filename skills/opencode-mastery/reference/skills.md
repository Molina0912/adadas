# Skills Complete Reference

Source: <https://opencode.ai/docs/skills>

## Overview

Skills define reusable behavior via SKILL.md definitions. They enable OpenCode to handle specific tasks by providing detailed instructions.

## Skill Structure

```
skill-name/
├── SKILL.md (required)
│   ├── YAML frontmatter (name, description required)
│   └── Markdown instructions
└── Bundled Resources (optional)
    ├── scripts/    - Executable code
    ├── references/ - Documentation
    └── assets/     - Templates, icons
```

## SKILL.md Format

```markdown
---
name: skill-name
description: |
  One sentence covering what this skill does AND when to trigger it.
  Front-load the literal keywords or filenames the user is likely to say.
  Use ONLY when... (for specific triggers)
  Use when... (for general triggers)
license: MIT
compatibility: ["opencode@1.0.0"]
---

# Skill Name

## Introduction
Brief description of the skill's purpose.

## Usage
When and how to use the skill.

## Examples
Real-world examples of skill usage.

## Reference
Detailed technical reference.
```

## Frontmatter Fields

| Field | Required | Description |
|-------|----------|-------------|
| `name` | Yes | Lowercase, hyphen-separated, up to 64 chars |
| `description` | Yes | What skill does AND when to trigger |
| `license` | No | License identifier |
| `compatibility` | No | Version compatibility array |
| `metadata` | No | String-string key-value pairs |

## Description Writing Guide

The description is the PRIMARY triggering mechanism. Include:

1. **What it does**: Clear statement of capability
2. **When to trigger**: Specific contexts and keywords
3. **Trigger keywords**: File names, patterns, user phrases

### Good Description Example

```markdown
description: |
  Code quality enforcement with anti-spaghetti rules. Use when:
  - User mentions "code review", "quality", "clean code"
  - Files exceed 150 lines or functions exceed 30 lines
  - Checking OWASP security compliance
  - Creating new files or modifying existing ones
  - "verify", "check", "review" code quality
```

### Bad Description Example

```markdown
description: "Helps with code."
```

## Skill Discovery

OpenCode scans for skills in these locations (in order):

1. Project: `.opencode/skill/<name>/SKILL.md`
2. Project: `.opencode/skills/<name>/SKILL.md`
3. Global: `~/.config/opencode/skill/<name>/SKILL.md`
4. Global: `~/.config/opencode/skills/<name>/SKILL.md`
5. External (auto-loaded): `~/.claude/skills/<name>/SKILL.md`
6. External (auto-loaded): `~/.agents/skills/<name>/SKILL.md`

## Skills Configuration

```json
{
  "skills": {
    "paths": [".opencode/skills", "/abs/path/to/skills"],
    "urls": ["https://example.com/.well-known/skills/"]
  }
}
```

### paths
Array of directories to scan recursively for `**/SKILL.md`

### urls
Array of URLs serving skill lists in JSON format:
```json
{
  "skills": [
    {
      "name": "my-skill",
      "description": "...",
      "url": "https://example.com/skills/my-skill/"
    }
  ]
}
```

## Skill Loading

Skills use a three-level loading system:

1. **Metadata** (~100 words): name + description - Always in context
2. **SKILL.md body** (<500 lines): Full instructions - In context when triggered
3. **Bundled resources**: Scripts, references - Loaded as needed

## Progressive Disclosure Example

```
opencode-mastery/
├── SKILL.md (workflow + selection)
└── reference/
    ├── config-schema.md   (detailed config reference)
    ├── agents.md          (agent configuration)
    ├── commands.md        (command creation)
    ├── plugins.md         (plugin development)
    ├── mcp-servers.md     (MCP setup)
    └── troubleshooting.md  (common issues)
```

Claude reads only the relevant reference file based on context.

## Skill Examples

### Zero Errors Skill (Quality Enforcement)

```markdown
---
name: zero-errors
description: |
  Anti-spaghetti and zero errors rules for code quality. Use when:
  - "code review", "quality", "clean code" mentioned
  - Files > 150 lines or functions > 30 lines
  - OWASP, security, MLOps mentioned
  - "verify", "check", "review" code quality
  - Creating or modifying code files
---

# Zero Errors Rules

## Limits (MANDATORY)
- MAX 150 lines per file
- MAX 30 lines per function
- MAX 10 imports per file
- MAX 4 arguments per function

## PROHIBITED Files (NEVER create)
- utils.ts, helpers.ts, manager.ts, handler.ts
- functions.ts, lib.ts, core.ts, main.ts
- utilities.ts, misc.ts, shared.ts, common.ts

## Checklist
1. File < 150 lines?
2. Function < 30 lines?
3. Descriptive names (noun-noun)?
4. ONE responsibility?
5. Decoupled components?

## Security (OWASP)
- SQL Injection → Use prepared statements
- XSS → Sanitize outputs
- Credentials → NEVER hardcode, use env vars

## Output
After any change:
1. IDENTIFY - What files changed?
2. READ - Read modified files
3. VERIFY - Full checklist
4. CORRECT - Fix issues
5. DOCUMENT - Report changes
```

### MCP Integration Skill

```markdown
---
name: mcp-tools
description: |
  MCP (Model Context Protocol) server management. Use when:
  - "MCP", "model context protocol" mentioned
  - Configuring MCP servers
  - Adding tools via MCP
  - MCP authentication issues
  - "mcp add", "mcp list", "mcp remove"
---

# MCP Tools Integration

## Add Local MCP Server

```json
{
  "mcp": {
    "my-server": {
      "type": "local",
      "command": ["npx", "-y", "@package/mcp"],
      "env": {},
      "enabled": true
    }
  }
}
```

## Add Remote MCP Server

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
        "clientSecret": "${SENTRY_CLIENT_SECRET}"
      }
    }
  }
}
```

## Verify MCP Status

```bash
opencode mcp list
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

## MCP Commands
- `opencode mcp add <name>` - Add MCP server
- `opencode mcp list` - List MCP servers
- `opencode mcp auth <name>` - Authenticate
- `opencode mcp logout <name>` - Logout
```

## Skill Discovery Rules

1. File must be named exactly `SKILL.md`
2. Must be in its own folder named after the skill
3. Folder name must match `name` in frontmatter
4. Skills without description are filtered out
5. Skills scanned recursively in skill paths

## Override Per Agent

```json
{
  "skills": {
    "paths": [".opencode/skills"]
  },
  "agent": {
    "my-agent": {
      "skills": {
        "paths": [".opencode/custom-skills"],
        "disable": ["other-skill"]
      }
    }
  }
}
```

## Disable Skill Tool

If skill conflicts with built-in tools:
```json
{
  "skills": {
    "disable_skill_tool": true
  }
}
```

## Troubleshooting Skills

### Skill Not Loading
1. Check file path: `<name>/SKILL.md`
2. Verify frontmatter has `name` and `description`
3. Check skill path is in `skills.paths`
4. Restart OpenCode after changes

### Skill Not Triggering
- Review description keywords
- Ensure task matches description
- Check for conflicting skills
- Verify skill is not disabled per-agent