# documentation-sync

// 📦 depende de: [[zero-errors]], [[decision-log]]
// 📤 exporta a: [[rules-readme]]

## filosofia

**si cambia la API o arquitectura, los docs se actualizan en el mismo cambio.**

## when applies

```
□ API endpoint cambia signature
□ API endpoint es nuevo
□ parametros de configuracion cambian
□ arquitectura de modulos cambia
□ decisiones de diseno son tomadas (decision-log)
□ nuevas dependencias agregadas
□ breaking changes introducidas
```

## checklist obligatorio

```
□ README principal actualizado con nueva feature?
□ API docs actualizadas si endpoint cambio?
□ decision log registrado si cambio arquitectural?
□ breaking changes documentadas en CHANGELOG?
□ .env.example actualizado si variables nuevas?
□ comments en codigo actualizados si semantica cambio?
```

## forbidden

```
□ crear feature sin docs
□ cambiar API sin actualizar docs
□ decision log vacio para refactors grandes
□ actualizar codigo y dejar docs desactualizadas
```

## document types

```
README.md           - guia general
docs/
├── api/            - endpoints, schemas
├── architecture/  - diagrams, decisions
├── decisions/      - ADRs (Architecture Decision Records)
└── guides/         - how-tos especificos
```

## sync rule

```
mismo commit que el cambio de codigo:
- codigo: nuevo feature
- docs: documentacion de ese feature
```

No hacer commits separados de docs y codigo para la misma feature.

---

✅ aplica: docs_como_codigo + sync_inmediato + trazabilidad