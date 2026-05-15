---
name: deploy-to-vercel
description: Deploy applications and websites to Vercel. Use when the user requests deployment actions like "deploy my app", "deploy and give me the link", "push this live", or "create a preview deployment".
metadata:
  author: vercel
  version: "3.0.0"
---

# Deploy to Vercel

Deploy any project to Vercel. **Always deploy as preview** (not production) unless the user explicitly asks for production.

The goal is to get the user into the best long-term setup: their project linked to Vercel with git-push deploys. Every method below tries to move the user closer to that state.

## Step 1: Gather Project State

Run all four checks before deciding which method to use:

```bash
# 1. Check for a git remote
git remote get-url origin 2>/dev/null

# 2. Check if locally linked to a Vercel project
cat .vercel/project.json 2>/dev/null || cat .vercel/repo.json 2>/dev/null

# 3. Check if the Vercel CLI is installed and authenticated
vercel whoami 2>/dev/null

# 4. List available teams (if authenticated)
vercel teams list --format json 2>/dev/null
```

## Step 2: Choose a Deploy Method

### Linked + has git remote → Git Push (Preferred)

```bash
# Ask user before pushing
git add .
git commit -m "deploy: <description>"
git push
```

### Linked + no git remote → `vercel deploy`

```bash
vercel deploy [path] -y --no-wait
```

### Not linked + CLI authenticated → Link first

```bash
vercel link --repo --scope <team-slug>
# Then deploy via git push or CLI
```

### Not linked + CLI not authenticated → Install, auth, link, deploy

```bash
npm install -g vercel
vercel login
vercel link --repo --scope <team-slug>
vercel deploy -y --no-wait --scope <team-slug>
```

## Output

Always show the user the deployment URL.

## Troubleshooting

- **Network Egress Error:** Tell user to add `*.vercel.com` to allowed domains
- **CLI Auth Failure:** Fall back to no-auth deploy script
- **Escalated Network:** Use `sandbox_permissions=require_escalated` for deploy command