# decision-log

// 📦 depende de: [[zero-errors]], [[cognitive-loop]]
// 📤 exporta a: [[rules-readme]]

## regla

**todo cambio estructural requiere decision log.**

## cuando aplica

```
□ refactor de arquitectura
□ introduccion de nueva dependencia
□ cambio de patron de diseno
□ desicion que afecta multiples modulos
□取舍 que elimina opciones (tradeoff consciente)
□ optimizacion que sacrifica legibilidad
```

## decision log entry template

Crear en `docs/decisions/XXX-short-description.md`:

```md
# DECISION: [titulo]

date: YYYY-MM-DD
status: accepted | deprecated | superseded

## contexto

[problema que se intenta resolver]

## decision tomada

[que se decidio y por que]

## alternativas consideradas

1. [opcion 1]
   - pros: [...]
   - cons: [...]
   
2. [opcion 2]
   - pros: [...]
   - cons: [...]

## consecuencias

positive:
- [lista]

negative:
- [lista]

## tradeoffs explícitos

[tradeoffs consciously accepted]

## revisado por

[quien aprobo la decision]
```

## ejemplos

### ejemplo 1: database choice

```
## contexto
Necesitamos persistencia para sesiones de usuario.

## decision
Usar Redis para cache de sesiones, PostgreSQL para data durable.

## tradeoffs
- Redis es volatile: aceptamos perdida de sesiones en crash rara
- Complexity de 2 sistemas: aceptamos la carga operacional

## alternativas
1. Solo PostgreSQL: mas simple pero mas lento para sesiones
2. Solo Redis: riesgo de perdida de datos
```

### ejemplo 2: API design

```
## contexto
Cliente necesita filtrar por multiples campos dinamicamente.

## decision
Usar query builder con schema validation en vez de raw SQL dinamico.

## tradeoffs
- Menos flexible que raw SQL: aceptamos
- Performance: aceptamos overhead menor

## alternativas
1. Raw SQL dinamico: riesgo de injection
2. ORM query builder: menos expresivo para casos complejos
```

## checklist

```
□ toda decision estructural fue documentada?
□ el log esta en docs/decisions/?
□ se registraron pros/contras/tradeoffs?
□ la decision tiene fecha y status?
□ los archivos afectados estan actualizados?
```

## archivos generados

```
docs/
└── decisions/
    ├── 001-database-choice.md
    ├── 002-auth-refactor.md
    └── 003-frontend-state.md
```

---

✅ aplica: memoria_arquitectonica + trazabilidad + decisiones_explicitas