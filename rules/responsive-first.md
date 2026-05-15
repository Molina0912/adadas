# responsive-first

// 📦 depende de: [[zero-errors]], [[accessibility-baseline]]
// 📤 exporta a: [[rules-readme]]

## regla

**todo componente debe validar: mobile, tablet, desktop.**

## breakpoints estandard

```
mobile:  < 640px
tablet:  640px - 1024px
desktop: > 1024px
```

## checklist obligatorio

```
□ overflow no rompe layout en ninguna resolucion?
□ tap targets (botones, links) minimo 44x44px en mobile?
□ breakpoint principal considerado?
□ container principal no excede max-width legible?
□ texto es legible sin zoom forzado?
□ scroll horizontal no introducido accidentalmente?
□ grid/flex se adapta sin romper?
□ imagenes con width/height o aspect-ratio para evitar CLS?
□ no hay contenido cortado en mobile portrait?
```

## testing obligatorio

```
□ inspector de dispositivos en browser
□ verificar con Device Mode en DevTools
□ probar portrait y landscape en mobile
□ verificar tablet portrait y landscape
```

## violaciones comunes

```css
/* ❌ INCORRECTO */
.container { width: 1400px; }

/* ✅ CORRECTO */
.container { max-width: 1400px; width: 100%; }

/* ❌ INCORRECTO */
.button { padding: 2px 4px; } /* tap target muy pequeno */

/* ✅ CORRECTO */
.button { padding: 12px 24px; min-height: 44px; }
```

---

✅ aplica: mobile_first + responsive_design + no CLS