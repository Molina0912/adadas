# accessibility-baseline

## regla

**toda ui nueva cumple wcag aa minimo.**

## checklist obligatorio

```
□ html semantico (header, nav, main, article, footer)
□ un solo <h1> por pagina, jerarquia h2-h6 ordenada
□ todas las imagenes con alt descriptivo (o alt="" si decorativas)
□ inputs con <label> asociado (for/htmlFor)
□ contraste texto/fondo >= 4.5:1 (texto normal) o 3:1 (texto grande)
□ navegacion completa por teclado (tab, enter, esc)
□ focus visible (no quitar outline sin reemplazar)
□ aria-label en botones solo-icono
□ roles aria correctos (button, dialog, alert, etc.)
□ skip-link al contenido principal
□ formularios con mensajes de error asociados (aria-describedby)
```

## prohibido

- `<div onclick>` en lugar de `<button>`
- `outline: none` sin alternativa visual
- color como unico indicador (rojo = error sin texto)
- placeholders como sustituto de labels
- modales que no atrapan focus
- autoplay con sonido
- texto en imagenes sin alternativa textual

## componentes criticos

| componente | requisitos |
|------------|-----------|
| modal/dialog | focus trap, esc cierra, aria-modal, restaurar focus al cerrar |
| dropdown | navegacion con flechas, esc cierra, aria-expanded |
| tabs | flechas izq/der, aria-selected, aria-controls |
| toast | aria-live="polite", auto-dismiss configurable |

## verificacion

ejecutar `axe-core` o lighthouse a11y. reportar issues criticos antes de entregar.

---

✅ aplica: wcag_aa + inclusion + cumplimiento_legal
