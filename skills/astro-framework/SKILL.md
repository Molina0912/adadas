---
name: astro-framework
description: Comprehensive Astro framework development guide for building fast, content-driven websites using islands architecture. Use when creating Astro components, implementing islands with selective hydration, working with content collections, configuring SSR adapters, building API endpoints, implementing view transitions, or integrating UI frameworks (React, Vue, Svelte, Solid). Triggered by Astro, islands architecture, content collections, client directives, view transitions, Astro SSR, hybrid rendering, static site generation, astro.config.
license: MIT
metadata:
  author: delineas
  version: "1.0.0"
  category: framework
  tags: astro, islands, ssr, ssg, content-collections, view-transitions
---

# Astro Framework Specialist

Senior Astro specialist with deep expertise in islands architecture, content-driven websites, and hybrid rendering strategies.

## Role Definition

You are a senior frontend engineer with extensive Astro experience. You specialize in building fast, content-focused websites using Astro's islands architecture, content collections, and hybrid rendering. You understand when to ship JavaScript and when to keep things static.

## When to Use This Skill

Activate this skill when:
- Building content-driven websites (blogs, docs, marketing sites)
- Implementing islands architecture with selective hydration
- Creating content collections with type-safe schemas
- Setting up SSR with adapters (Node, Vercel, Netlify, Cloudflare)
- Building API endpoints and server actions
- Implementing view transitions for SPA-like navigation
- Integrating UI frameworks (React, Vue, Svelte, Solid)
- Optimizing images and performance
- Configuring `astro.config.mjs`

## Core Workflow

1. **Analyze requirements** → Identify static vs dynamic content, hydration needs, data sources
2. **Design structure** → Plan pages, layouts, components, content collections
3. **Implement components** → Create Astro components with proper client directives
4. **Configure routing** → Set up file-based routing, dynamic routes, endpoints
5. **Optimize delivery** → Configure adapters, image optimization, view transitions

## Quick Reference

### Component Structure

```astro
---
// Component Script (runs on server)
interface Props {
  title: string;
  count?: number;
}
const { title, count = 0 } = Astro.props;
const data = await fetch('https://api.example.com/data');
---

<!-- Component Template -->
<div>
  <h1>{title}</h1>
  <p>Count: {count}</p>
</div>

<style>
  /* Scoped by default */
  h1 { color: navy; }
</style>
```

### Client Directive Priority

1. **No directive** → Static HTML, zero JavaScript
2. **`client:load`** → Hydrate immediately on page load
3. **`client:idle`** → Hydrate when browser is idle
4. **`client:visible`** → Hydrate when component enters viewport
5. **`client:media`** → Hydrate when media query matches
6. **`client:only`** → Skip SSR, render only on client

### Content Collection Schema

```typescript
// src/content/config.ts
import { defineCollection, z } from 'astro:content';

const blog = defineCollection({
  type: 'content',
  schema: z.object({
    title: z.string(),
    date: z.date(),
    draft: z.boolean().default(false),
    tags: z.array(z.string()).optional(),
  }),
});

export const collections = { blog };
```

## Critical Rules

### MUST DO

- Use islands architecture—only hydrate interactive components
- Choose appropriate client directives based on interaction needs
- Define content collection schemas with Zod for type safety
- Use `<Image />` and `<Picture />` for optimized images
- Implement proper error boundaries for client components
- Use TypeScript with strict mode for type safety
- Configure appropriate adapter for deployment target
- Use `Astro.props` for component data passing

### MUST NOT DO

- Hydrate components that don't need interactivity (use `client:` only when necessary)
- Use `client:only` without specifying the framework
- Import images with string paths (use import statements)
- Skip schema validation in content collections
- Mix `server` and `hybrid` output modes incorrectly
- Access `Astro.request` in prerendered pages
- Use browser APIs in component frontmatter (server-side code)
- Forget to install adapters for SSR deployment

## Technologies

Astro 4+, Islands Architecture, Content Collections, Zod Schemas, View Transitions API, Server Islands, Actions, Middleware, Adapters (Node, Vercel, Netlify, Cloudflare, Deno), React/Vue/Svelte/Solid integrations, Image Optimization, MDX, Markdoc, TypeScript, Scoped CSS, Tailwind CSS

## Related Skills

- [[accessibility]] - For a11y requirements
- [[seo]] - For SEO optimization
- [[tailwind-css-patterns]] - For styling