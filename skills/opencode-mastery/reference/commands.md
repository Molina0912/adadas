# Commands Complete Reference

Source: <https://opencode.ai/docs/commands>

## Overview

Commands are custom shortcuts that trigger AI-powered actions with predefined prompts. They appear in the TUI and can be executed via slash commands.

## Command Structure

### Inline in opencode.json

```json
{
  "command": {
    "deploy": {
      "description": "Deploy application to production",
      "prompt": "Deploy the application following these steps:\n1. Run tests\n2. Build production bundle\n3. Deploy to staging\n4. Run smoke tests\n5. Deploy to production"
    }
  }
}
```

### Command Options

| Field | Type | Description |
|-------|------|-------------|
| `description` | string | What the command does (shown in UI) |
| `prompt` | string | System prompt for the command |
| `agent` | string | (Optional) Agent to use |
| `arguments` | array | (Optional) Argument definitions |
| `shell` | string | (Optional) Shell to use |

## Command File Format

Create `.opencode/commands/<name>.md` or `~/.config/opencode/commands/<name>.md`:

```markdown
---
description: Code review with anti-spaghetti checklist
agent: zero-errors
arguments:
  - name: target
    description: Files or directories to review
    required: true
---

Review the following code with zero errors checklist:

1. File size < 150 lines?
2. Function size < 30 lines?
3. Descriptive names?
4. ONE responsibility?
5. Decoupled components?

Target: {{target}}
```

## Arguments

```markdown
---
description: Analyze code quality
arguments:
  - name: path
    description: Path to analyze
    required: true
  - name: depth
    description: Analysis depth (basic/detailed)
    required: false
    default: basic
---

Analyze code at {{path}} with {{depth}} depth.
```

## Command Examples

### Code Review Command

```json
{
  "command": {
    "review": {
      "description": "Review code with zero errors checklist",
      "prompt": "You are a code reviewer following zero errors methodology:\n\n1. Check: MAX 150 lines/file, MAX 30 lines/function\n2. Check: No prohibited files (utils.ts, helpers.ts, etc)\n3. Check: Descriptive names (noun-noun)\n4. Check: ONE responsibility per file\n5. Check: Decoupled components\n6. Check: OWASP security (no hardcoded creds, SQL injection, XSS)\n7. For ML: Check MLOps reproducibility\n\nReport violations with file:line:issue format."
    },
    "security-audit": {
      "description": "Full security audit",
      "prompt": "Perform comprehensive security audit checking:\n- OWASP Top 10\n- SQL Injection\n- XSS vulnerabilities\n- CSRF\n- Authentication issues\n- Hardcoded secrets\n- Input validation\n- Output encoding"
    }
  }
}
```

### Deploy Command

```json
{
  "command": {
    "deploy": {
      "description": "Deploy application",
      "agent": "zero-errors",
      "prompt": "Deploy application following workflow:\n\n1. PRE-DEPLOY:\n   - Run all tests: npm test\n   - Run linting: npm run lint\n   - Run type check: tsc --noEmit\n\n2. BUILD:\n   - Clean build: rm -rf dist/\n   - Production build: npm run build\n\n3. DEPLOY STAGING:\n   - Deploy to staging environment\n   - Run smoke tests\n   - Verify health checks\n\n4. DEPLOY PRODUCTION:\n   - Blue-green or canary deployment\n   - Monitor metrics\n   - Verify no errors\n\n5. POST-DEPLOY:\n   - Update documentation if needed\n   - Notify team\n   - Monitor logs for 15 minutes"
    }
  }
}
```

### Database Command

```json
{
  "command": {
    "migrate": {
      "description": "Run database migrations",
      "prompt": "Execute database migration:\n\n1. Create backup of current database\n2. Review migration files\n3. Run migration in transaction\n4. Verify data integrity\n5. Run rollback plan if failed\n\nUse safe patterns:\n- Use transactions for data migrations\n- Add IF NOT EXISTS for schema changes\n- Use idempotent operations"
    }
  }
}
```

### Test Command

```json
{
  "command": {
    "test": {
      "description": "Run tests with coverage",
      "prompt": "Run comprehensive tests:\n\n1. Unit tests: npm test\n2. Integration tests: npm run test:integration\n3. Coverage report: npm run test:coverage\n4. Generate coverage badge\n\n5. If tests fail:\n   - Report which tests failed\n   - Show error messages\n   - Suggest fixes\n   - DO NOT auto-fix without approval"
    }
  }
}
```

### Refactor Command

```json
{
  "command": {
    "refactor": {
      "description": "Refactor code to follow best practices",
      "prompt": "Refactor code following zero errors rules:\n\n1. Split files > 150 lines\n2. Split functions > 30 lines\n3. Rename to descriptive names\n4. Extract duplicate logic to shared modules\n5. Ensure single responsibility\n6. Add proper error handling\n\n7. Before refactoring:\n   - Ensure tests exist and pass\n   - Create git backup commit\n   - Document current architecture\n\n8. After refactoring:\n   - Run all tests\n   - Verify no functionality broken\n   - Update documentation"
    }
  }
}
```

## Using Commands in TUI

1. Type `/` in TUI to see command list
2. Type `/deploy` to execute deploy command
3. Arguments can be passed: `/review src/`

## Command Chaining

Commands can chain with agents:

```markdown
---
description: Full stack development workflow
agent: build
---

You are a full stack developer. Handle:
1. Backend API development
2. Frontend component creation
3. Database design and migrations
4. Testing implementation
5. Documentation updates

Follow zero errors methodology for all code.
```

## Shell Commands

Commands can include shell execution:

```markdown
---
description: Quick project status
shell: bash
---

Check project status with:
- git status
- npm outdated
- Disk usage
- Recent commits
```

## Best Practices

1. **Descriptive names**: Use verb-noun format (deploy, review-code, run-tests)
2. **Clear descriptions**: Explain what the command does
3. **Focused prompts**: One main purpose per command
4. **Error handling**: Include error recovery steps
5. **Idempotent**: Commands should be safe to run multiple times