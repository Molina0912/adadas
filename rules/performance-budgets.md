# performance-budgets

## regla

**presupuestos duros. excederlos requiere justificacion.**

## frontend

| metrica | budget |
|---------|--------|
| lcp (largest contentful paint) | < 2.5s |
| inp (interaction to next paint) | < 200ms |
| cls (cumulative layout shift) | < 0.1 |
| js inicial (gzip) | < 200kb |
| css inicial (gzip) | < 50kb |
| imagen hero | < 200kb (webp/avif) |
| ttfb | < 600ms |

## backend

| metrica | budget |
|---------|--------|
| p50 endpoint comun | < 100ms |
| p95 endpoint comun | < 300ms |
| p99 endpoint critico | < 1s |
| cold start serverless | < 1s |
| query db sin indice | prohibido en hot path |

## obligatorio en frontend

- imagenes con `loading="lazy"` salvo above-the-fold
- formato moderno (webp/avif) con fallback
- code-splitting por ruta
- prefetch en links visibles
- fonts con `font-display: swap`
- evitar layout shifts (reservar espacio con width/height)

## obligatorio en backend

- indices en columnas de filtro/join frecuente
- paginacion en listados (max 50 por defecto)
- cache para datos estaticos (cdn / redis / etag)
- timeouts en llamadas externas (max 5s)
- circuit breaker en integraciones criticas

## prohibido sin justificar

- bundle > budget
- query n+1
- llamadas http en serie cuando podrian ser paralelas
- imagenes sin optimizar
- librerias enteras importadas para una sola funcion

---

✅ aplica: ux_rapida + costos_bajos + escalabilidad
