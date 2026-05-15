---
name: seo
description: Optimize for search engine visibility and ranking. Use when asked to "improve SEO", "optimize for search", "fix meta tags", "add structured data", "sitemap optimization", or "search engine optimization".
license: MIT
metadata:
  author: web-quality-skills
  version: "1.0"
---

# SEO Optimization

Search engine optimization based on Lighthouse SEO audits and Google Search guidelines. Focus on technical SEO, on-page optimization, and structured data.

## SEO Fundamentals

Search ranking factors (approximate influence):

| Factor | Influence | This Skill |
|--------|-----------|------------|
| Content quality & relevance | ~40% | Partial (structure) |
| Backlinks & authority | ~25% | ✗ |
| Technical SEO | ~15% | ✓ |
| Page experience (Core Web Vitals) | ~10% | See [[core-web-vitals]] |
| On-page SEO | ~10% | ✓ |

---

## Technical SEO

### robots.txt

```text
User-agent: *
Allow: /

Disallow: /admin/
Disallow: /api/

Sitemap: https://example.com/sitemap.xml
```

### Canonical URLs

```html
<link rel="canonical" href="https://example.com/current-page">
```

### URL Structure

```
✅ Good: https://example.com/products/blue-widget
❌ Poor: https://example.com/p?id=12345
```

---

## On-Page SEO

### Title Tags

```html
<!-- ❌ Missing or generic -->
<title>Page</title>

<!-- ✅ Descriptive with primary keyword -->
<title>Blue Widgets for Sale | Premium Quality | Example Store</title>
```

**Guidelines**: 50-60 characters, primary keyword near beginning, unique for every page.

### Meta Descriptions

```html
<meta name="description" content="Shop premium blue widgets with free shipping. 30-day returns. Order today and save 20%.">
```

**Guidelines**: 150-160 characters, include primary keyword, compelling call-to-action.

### Heading Structure

```html
<!-- ✅ Single h1, logical hierarchy -->
<h1>Blue Widgets - Premium Quality</h1>
  <h2>Product Features</h2>
  <h2>Customer Reviews</h2>
```

---

## Structured Data (JSON-LD)

### Organization

```html
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "Organization",
  "name": "Example Company",
  "url": "https://example.com"
}
</script>
```

### Article

```html
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "Article",
  "headline": "How to Choose the Right Widget",
  "datePublished": "2024-01-15"
}
</script>
```

### FAQ

```html
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "FAQPage",
  "mainEntity": [{
    "@type": "Question",
    "name": "What colors are available?",
    "acceptedAnswer": { "@type": "Answer", "text": "Blue, red, and green." }
  }]
}
</script>
```

---

## SEO Audit Checklist

### Critical
- [ ] HTTPS enabled
- [ ] robots.txt allows crawling
- [ ] No `noindex` on important pages
- [ ] Title tags present and unique
- [ ] Single `<h1>` per page

### High Priority
- [ ] Meta descriptions present
- [ ] Sitemap submitted
- [ ] Canonical URLs set
- [ ] Mobile-responsive
- [ ] Core Web Vitals passing

---

## Tools

| Tool | Use |
|------|-----|
| Google Search Console | Monitor indexing, fix issues |
| Google PageSpeed Insights | Performance + Core Web Vitals |
| Rich Results Test | Validate structured data |
| Lighthouse | Full SEO audit |

## References

- [Google Search Central](https://developers.google.com/search)
- [Schema.org](https://schema.org/)