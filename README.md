# opencode config

configuración global de opencode en `~/.config/opencode/`.

## estructura

```
opencode/
├── agents/          # agentes personalizados
├── commands/        # comandos /plan, /verify, etc
├── rules/           # reglas de validacion (21 reglas)
├── skills/          # skills especializados
├── themes/          # temas de color
├── AGENTS.md        # instrucciones del agente
├── opencode.json    # configuracion
└── PERSISTENCE-CORE.md  # memoria post-cambio
```

## rules disponibles

| categoria | reglas |
|-----------|--------|
| 🔴 critica | zero-errors, js-module-validator, mcp-documentation, context-first, verify-before-claim, parallel-tool-calls, secrets-and-env, error-recovery |
| 🟡 alta | scope-discipline, edit-over-rewrite, dependency-hygiene, test-pyramid, commit-atomicity |
| 🟢 pulido | logging-standards, accessibility-baseline, performance-budgets, response-format, stop-and-ask, memory-discipline |

## agents

- `zero-errors-agent` — agente primary por defecto

## comandos

- `/plan-zero-errors` — planificacion estructurada
- `/verify-delivery` — checklist pre-entrega
- `/verify-security` — auditoria owasp
- `/review-code` — code review
- `/review-ai-code` — review para codigo generado por ia
- `/test-comprehensive` — tests con coverage
- `/autocommit` — commits semanticos

## reiniciar

despues de modificar cualquier archivo de configuracion, **reiniciar opencode** para que tome los cambios.