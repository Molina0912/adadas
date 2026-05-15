# Integrations Complete Reference

Source: <https://opencode.ai/docs/github>, <https://opencode.ai/docs/gitlab>, <https://opencode.ai/docs/acp>

## GitHub Integration

### Features

- Respond to issues and pull requests
- Triage issues automatically
- Review PRs
- Schedule automated tasks

### Installation

#### GitHub App
```bash
opencode github install
```

#### Manual Setup

1. Create Personal Access Token at <https://github.com/settings/tokens>
2. Add to environment or config:
```json
{
  "provider": {
    "github": {
      "options": {
        "token": "${GITHUB_TOKEN}"
      }
    }
  }
}
```

### Configuration

```json
{
  "github": {
    "token": "${GITHUB_TOKEN}",
    "app": {
      "install_id": "12345",
      "private_key": "${GITHUB_APP_PRIVATE_KEY}"
    }
  }
}
```

### Supported Events

| Event | Description |
|-------|-------------|
| `issues` | New issue opened |
| `issue_comment` | Comment on issue |
| `pull_request` | PR opened/updated |
| `pull_request_review` | PR review submitted |
| `schedule` | Cron-based execution |

### Custom Prompts

```json
{
  "github": {
    "prompts": {
      "issue_triage": "You are a helpful assistant that triages GitHub issues...",
      "pr_review": "You are a code reviewer specializing in security..."
    }
  }
}
```

### Examples

#### Issue Triage
```yaml
on:
  issues:
    types: [opened]

jobs:
  opencode:
    runs-on: ubuntu-latest
    steps:
      - uses: opencodeai/github-action@v1
        with:
          api_key: ${{ secrets.OPENCODE_API_KEY }}
          action: triage-issue
```

#### PR Review
```yaml
on:
  pull_request:
    types: [opened, synchronize]

jobs:
  review:
    runs-on: ubuntu-latest
    steps:
      - uses: opencodeai/github-action@v1
        with:
          api_key: ${{ secrets.OPENCODE_API_KEY }}
          action: review-pr
```

## GitLab Integration

### Features

- Respond to issues and merge requests
- CI/CD integration
- GitLab Duo compatibility

### GitLab CI Component

```yaml
# .gitlab-ci.yml
include:
  - component: nagyv/gitlab-opencode/agent@latest
    inputs:
      api_key: $OPENCODE_API_KEY
```

### Setup

1. Get GitLab token at <https://gitlab.com/-/user_settings/personal_access_tokens>
2. Configure:
```json
{
  "gitlab": {
    "token": "${GITLAB_TOKEN}",
    "url": "https://gitlab.com"
  }
}
```

### GitLab Duo Compatibility

OpenCode integrates with GitLab Duo:

```json
{
  "gitlab": {
    "duo_enabled": true
  }
}
```

### Examples

#### MR Review
```yaml
opencode_mr_review:
  stage: review
  script:
    - opencode gitlab mr-review $CI_MERGE_REQUEST_IID
```

## ACP (Agent Client Protocol)

### Overview

ACP enables OpenCode to work with ACP-compatible editors like Zed, JetBrains, and Neovim plugins.

### Supported Editors

| Editor | Status |
|--------|--------|
| Zed | ✅ Stable |
| JetBrains IDEs | ✅ Stable |
| Avante.nvim | ✅ Stable |
| CodeCompanion.nvim | ✅ Stable |

### Zed Configuration

```json
{
  "acp": {
    "url": "http://localhost:4096",
    "token": "${ACP_TOKEN}"
  }
}
```

### JetBrains Configuration

1. Install AI Assistant plugin
2. Configure ACP endpoint in settings
3. Set API key

### Avante.nvim (Neovim)

```lua
-- ~/.config/nvim/lua/plugins/opencode.lua
return {
  "yetone/avante.nvim",
  opts = {
    opencode = {
      api_key = os.getenv("OPENCODE_API_KEY"),
      endpoint = "http://localhost:4096"
    }
  }
}
```

### CodeCompanion.nvim (Neovim)

Set environment variable:
```bash
export OPENCODE_API_KEY="your-api-key"
export OPENCODE_ENDPOINT="http://localhost:4096"
```

### ACP Server

Start ACP server:
```bash
opencode serve --acp --port 4096
```

### ACP Auth

```bash
# Login
opencode auth login --provider acp

# Check status
opencode acp status
```

## IDE Integration

### VS Code

1. Install OpenCode extension from marketplace
2. Configure API key in settings
3. Use `/` commands in chat

### Cursor

1. Install OpenCode extension
2. Configure endpoint
3. Access via CMD+L

### Configuration

```json
{
  "ide": {
    "extension": {
      "api_key": "${OPENCODE_API_KEY}",
      "endpoint": "http://localhost:4096"
    }
  }
}
```

## Web Integration

### Web Interface

Access OpenCode via browser at `http://localhost:4096` (default port).

### Configuration

```json
{
  "web": {
    "port": 4096,
    "hostname": "localhost",
    "cors": true
  }
}
```

### Start Web Interface

```bash
opencode web
opencode web --port 8080
opencode web --hostname 0.0.0.0
```

### Authentication

```bash
# Login
opencode auth login

# Web auto-authenticates via session
```

## Slack Integration

Via MCP server:
```json
{
  "mcp": {
    "slack": {
      "type": "remote",
      "url": "https://slack.com/api/mcp",
      "headers": {
        "Authorization": "Bearer ${SLACK_BOT_TOKEN}"
      }
    }
  }
}
```

## Discord Integration

Via custom plugin:
```typescript
// .opencode/plugin/discord.ts
export default (async ({ client }) => {
  return {
    "chat.message": async (message) => {
      if (message.content.startsWith("!")) {
        // Handle Discord commands
      }
    }
  }
}) satisfies Plugin
```