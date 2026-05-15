# rules-readme

// 📦 depende de: [[zero-errors]], [[js-module-validator]], [[mcp-documentation]]
// 📤 exporta a: [[opencode.json]], [[agents-md]], [[persistence-md]]

## vision general

este directorio contiene reglas de validacion cargadas en el array `instructions` de opencode. todas las reglas estan interconectadas y deben aplicarse juntas para generacion de codigo consistente y de alta calidad.

## matriz de reglas

| regla | proposito | enfoque principal |
|-------|-----------|-------------------|
| [[zero-errors]] | validacion anti-spaghetti | limites 150/30, archivos prohibidos, nomenclatura |
| [[js-module-validator]] | validacion de modulos es6 | consistencia export/import |
| [[mcp-documentation]] | uso de documentacion mcp | siempre verificar con context7/gitmcp |

## mapa de interconexion

```
┌─────────────────────────────────────────────────────────┐
│                    RULES INDEX                          │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  ┌──────────────┐    ┌──────────────────┐               │
│  │ zero-errors │←──→│ js-module-validator│               │
│  └──────┬───────┘    └──────────────────┘               │
│         │                    │                           │
│         │    ┌────────────────┴────────┐                 │
│         └────→     mcp-documentation  ←─────── proyecto  │
│                      (siempre usar)    void-collector  │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

## dependencias de reglas

### zero-errors (regla core)
- referencias: [[js-module-validator]], [[mcp-documentation]]
- seccion d (memoria) enlaza a [[persistence-md]] para verificacion post-cambio

### js-module-validator
- referencias: [[zero-errors]] (limites de tamano incluyen archivos js)
- referencias: [[mcp-documentation]] (verificacion mcp para codigo de librerias)

### mcp-documentation
- referencias: [[zero-errors]] (requiere validacion anti-spaghetti)
- aplicada a: proyecto void-collector (ejemplo con three.js)

## orden de carga

las reglas se cargan via `opencode.json`:

```json
"instructions": [
  "~/.config/opencode/AGENTS.md",
  "~/.config/opencode/PERSISTENCE.md",
  "~/.config/opencode/rules/zero-errors.md",
  "~/.config/opencode/rules/js-module-validator.md",
  "~/.config/opencode/rules/mcp-documentation.md"
]
```

## archivos relacionados

### configuracion de opencode
- [[opencode-json]] - archivo de configuracion principal

### proyecto ejemplo
- [[void-collector]] - juego three.js aplicando todas las reglas

### instrucciones core
- [[agents-md]] - instrucciones del agente y filosofia
- [[persistence-md]] - memoria y verificacion post-cambio

---

✅ reglas aplicadas: minúsculas + modularidad + trazabilidad_[[wiki]] + separacion_por_responsabilidad