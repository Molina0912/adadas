# i18n-a11y-by-default

// 📦 depende de: [[zero-errors]], [[accessibility-baseline]]
// 📤 exporta a: [[rules-readme]]

## filosofia

**toda UI debe ser internacionalizable y accesible desde el inicio, no anadida depois.**

## i18n rules

### texto visible

```ts
// ❌ INCORRECTO - texto hardcoded
return <button>Click here</button>;

// ✅ CORRECTO - usar sistema de traduccion
return <button>{t('button.submit')}</button>;

// ✅ CORRECTO - con reemplazo de variables
return <span>{t('greeting.name', { name: user.name })}</span>;
```

### fechas y numeros

```ts
// ❌ INCORRECTO
return <span>{new Date(date).toLocaleDateString()}</span>;

// ✅ CORRECTO
return <span>{formatDate(date, user.locale)}</span>;
```

## a11y rules avanzadas

### contraste

```
□ contraste texto/fondo >= 4.5:1 (texto normal)
□ contraste texto/fondo >= 3:1 (texto grande, 18pt+ o 14pt+ bold)
□ usar herramientas como axe-core o lighthouse para verificar
```

### navegacion por teclado

```
□ tab order sigue orden logico
□ focus visible en todos los interactivos
□ escape cierra modales/dropdowns
□ flechas navegan en menus/dropdowns
□ enter activa botones/enlaces
```

### screen readers

```
□ aria-live para contenido dinamico
□ aria-label en botones solo icono
□ aria-describedby para mensajes de error
□ roles correctos (button, dialog, alert, etc)
□ alt text en imagenes (o alt="" si decorativa)
```

## checklist

```
□ todo texto visible usa sistema de traduccion?
□ fechas formateadas segun locale?
□ numeros formateados segun locale?
□ contraste verificado >= 4.5:1?
□ navegacion por teclado completa?
□ focus visible en todos los interactivos?
□ aria labels donde corresponde?
□ alt text en imagenes?
□ errores de formulario anunciados?
```

---

✅ aplica: inclusion + i18n_primero + accesibilidad_por_defecto