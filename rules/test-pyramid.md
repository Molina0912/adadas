# test-pyramid

// 📦 depende de: [[zero-errors]], [[verify-before-claim]]

## regla

**toda funcion exportada nueva tiene su test en el mismo cambio.**

## piramide

```
    ┌─────────┐
    │   e2e   │  pocos, criticos (login, checkout, flujo principal)
    ├─────────┤
    │  integ  │  endpoints + db real / mock realista
    ├─────────┤
    │  unit   │  muchos, rapidos, aislados (logica pura)
    └─────────┘
```

## convencion

- archivo: `<nombre>.test.ts` al lado del original (no en `__tests__/` lejano)
- naming: `describe('<modulo>', () => { it('<comportamiento esperado>', ...) })`
- un test = un comportamiento, no un metodo

## que mockear

| capa | mockear? |
|------|----------|
| logica de dominio pura | no |
| llamadas http externas | si |
| acceso a db en unit tests | si |
| acceso a db en integration tests | no (db de test) |
| reloj / random | si (inyectar) |

## checklist por funcion exportada

```
□ caso feliz cubierto?
□ al menos 1 edge case (null, vacio, limite)?
□ al menos 1 caso de error (input invalido)?
□ test corre en < 100ms?
□ no depende de orden de ejecucion?
```

## prohibido

- tests con `setTimeout` reales (usa fake timers)
- tests que dependen de internet
- snapshots gigantes sin revision
- `expect(true).toBe(true)` o asserts vacios

---

✅ aplica: cobertura_significativa + regresion_zero
