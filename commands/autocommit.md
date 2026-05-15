---
name: autocommit
description: Create semantic commits from all available changes. Group files by purpose and commit each group separately. Use Conventional Commits format. Never make one big commit by default.
---

# Git Create Semantic Commits

Create semantic commits from all available changes.

Do not make one big commit by default.
Group files by purpose.
Commit each group separately.

## Goal

Turn the current working tree into clean, meaningful commits.
No guessing. No mega commits. No vague messages. No mixing unrelated changes.

## Steps

### 1. Inspect repository state

```bash
git status --short
git diff --cached
git diff
git ls-files --others --exclude-standard
```

Understand every available change before committing.

### 2. Detect issue key

```bash
git branch --show-current
```

Examples: `PROJ-123`, `POW-456`, `#123`

If there is a clear issue key, use it in every related commit. If not, commit without it.

### 3. Group changes semantically

Group files and hunks by intent:
- one bug fix
- one feature
- one refactor
- one test update
- one documentation change
- one dependency update

Use `git add -p` or stage files explicitly.

### 4. Create commits one by one

For each semantic group:

```bash
# Verify staged diff
git diff --cached

# Commit with Conventional Commits format
git commit -m "<type>(<scope>): <summary>"
```

With issue key:
```bash
git commit -m "<issue-key>: <type>(<scope>): <summary>"
```

## Commit Types

- `feat`: new feature
- `fix`: bug fix
- `docs`: documentation only
- `style`: formatting only, no logic change
- `refactor`: code change without behavior change
- `perf`: performance improvement
- `test`: tests added or updated
- `build`: build system or dependencies
- `ci`: CI/CD changes
- `chore`: maintenance
- `revert`: revert previous commit

## Message Rules

- Max 72 characters
- Use imperative mood: `Add`, `Fix`, `Update`, `Remove`
- Capitalize the summary
- No period at end
- Be specific

## Good vs Bad

```bash
# Good
git commit -m "fix(auth): Refresh token before request retry"
git commit -m "feat(profile): Add avatar upload"

# Bad
git commit -m "fixed auth"
git commit -m "updates"
git commit -m "WIP"
```

## Safety Rules

Never commit:
- secrets, API keys, tokens
- `.env` files with real values
- debug logs
- local editor files
- build artifacts
- unrelated experiments

## Final check

```bash
git status --short
```

Then report:
- commits created
- files intentionally left uncommitted
- anything skipped for safety

Done means clean semantic history, not just zero pending files.