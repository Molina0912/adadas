---
name: astro
description: Skill for building with the Astro web framework. Helps create Astro components and pages, configure SSR adapters, set up content collections, deploy static sites, and manage project structure and CLI commands. Use when the user needs to work with Astro, mentions .astro files, asks about static site generation (SSG), islands architecture, content collections, or deploying an Astro project.
license: MIT
metadata:
  authors: "Astro Team"
  version: "0.0.1"
---

# Astro Usage Guide

**Always consult [docs.astro.build](https://docs.astro.build) for code examples and latest API.**

Astro is the web framework for content-driven websites.

## Quick Reference

### File Location

CLI looks for `astro.config.js`, `astro.config.mjs`, `astro.config.cjs`, and `astro.config.ts` in: `./`. Use `--config` for custom path.

### CLI Commands

- `npx astro dev` - Start the development server.
- `npx astro build` - Build your project and write it to disk.
- `npx astro check` - Check your project for errors.
- `npx astro add` - Add an integration.
- `npx astro sync` - Generate TypeScript types for all Astro modules.

**Re-run after adding/changing plugins.**

### Project Structure

```
src/
├── components/     # Astro components
├── layouts/        # Layout components
├── pages/          # Routes (required)
├── styles/         # CSS/Sass files
└── content/        # Content collections
public/             # Static assets
astro.config.{js,mjs,cjs,ts}
tsconfig.json
```

## Adapters

```bash
# Add Node.js adapter
npx astro add node --yes

# Add Cloudflare adapter
npx astro add cloudflare --yes

# Add Netlify adapter
npx astro add netlify --yes

# Add Vercel adapter
npx astro add vercel --yes
```

## Resources

- [Docs](https://docs.astro.build)
- [Config Reference](https://docs.astro.build/en/reference/configuration-reference/)
- [GitHub](https://github.com/withastro/astro)