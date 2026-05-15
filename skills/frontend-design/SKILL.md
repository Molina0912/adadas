---
name: frontend-design
description: Create distinctive, production-grade frontend interfaces with high design quality. Use when building web components, pages, artifacts, posters, or applications (websites, landing pages, dashboards, React components, HTML/CSS layouts, or when styling/beautifying any web UI). Generates creative, polished code that avoids generic AI aesthetics.
license: MIT
---

# Frontend Design

This skill guides creation of distinctive, production-grade frontend interfaces that avoid generic "AI slop" aesthetics. Implement real working code with exceptional attention to aesthetic details and creative choices.

## Design Thinking

Before coding:
- **Purpose**: What problem does this interface solve? Who uses it?
- **Tone**: Choose an extreme—brutally minimal, maximalist, retro-futuristic, organic, luxury, playful, editorial, brutalist, art deco, soft pastel, industrial/utilitarian, etc.
- **Differentiation**: What makes this UNFORGETTABLE?

Then implement working code (HTML/CSS/JS, React, Vue, etc.) that is:
- Production-grade and functional
- Visually striking and memorable
- Cohesive with a clear aesthetic point-of-view

## Frontend Aesthetics Guidelines

Focus on:
- **Typography**: Choose distinctive fonts. Avoid Arial, Inter, Roboto. Pair distinctive display font with refined body font.
- **Color & Theme**: Commit to a cohesive aesthetic. Use CSS variables. Dominant colors with sharp accents.
- **Motion**: Use animations for effects. Prioritize CSS-only solutions. One well-orchestrated page load with staggered reveals creates more delight than scattered micro-interactions.
- **Spatial Composition**: Unexpected layouts. Asymmetry. Overlap. Diagonal flow. Grid-breaking elements. Generous negative space OR controlled density.
- **Backgrounds & Visual Details**: Create atmosphere and depth. Gradient meshes, noise textures, geometric patterns, layered transparencies, dramatic shadows, decorative borders, grain overlays.

## NEVER Use

- Generic fonts (Inter, Roboto, Arial, system fonts)
- Cliched color schemes (purple gradients on white)
- Predictable layouts and component patterns
- Cookie-cutter design that lacks character

## Design Examples

```tsx
// Distinctive Card Component
function ProductCard({ product }) {
  return (
    <div className="group relative bg-gradient-to-br from-stone-900 to-stone-800 rounded-2xl overflow-hidden border border-stone-700/50">
      <img className="w-full h-64 object-cover opacity-90 group-hover:opacity-100 transition-opacity" src={product.image} />
      <div className="absolute inset-0 bg-gradient-to-t from-black/80 via-transparent to-transparent" />
      <div className="absolute bottom-0 p-6">
        <h3 className="text-2xl font-bold text-white font-display">{product.name}</h3>
        <p className="text-stone-400 mt-2">{product.description}</p>
      </div>
    </div>
  );
}
```

## Match Implementation to Vision

- **Maximalist designs**: Need elaborate code with extensive animations and effects
- **Minimalist designs**: Need restraint, precision, careful attention to spacing and typography

Remember: Commit fully to a distinctive vision. No design should be the same twice.