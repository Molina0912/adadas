# commit-atomicity

## regla

**un commit = un cambio logico. mensaje claro, en imperativo, con contexto.**

## formato obligatorio

```
<tipo>(<scope>): <que cambio> 

<por que cambio (opcional, si no es obvio)>

<refs: #123, breaking changes, etc.>
```

## tipos validos

| tipo | uso |
|------|-----|
| feat | feature nueva visible al usuario |
| fix | correccion de bug |
| refactor | cambio interno sin cambiar comportamiento |
| perf | mejora de rendimiento |
| docs | solo documentacion |
| test | solo tests |
| chore | infra, deps, configs |
| style | formato (no logica) |

## ejemplos

```
✅ feat(auth): agregar login con google oauth
✅ fix(checkout): corregir calculo de iva con cupon
✅ refactor(user-repo): extraer queries a archivos por dominio
✅ chore(deps): actualizar prisma a v6.2.0
```

```
❌ wip
❌ fix stuff
❌ update
❌ asdfg
❌ "varios cambios"
```

## prohibido

- commits con > 10 archivos cambiados sin razon estructural
- mezclar feat + refactor + format en un solo commit
- commits que rompen el build
- amend a commits ya pusheados a rama compartida

## checklist pre-commit

```
□ el commit hace una sola cosa?
□ el mensaje explica el "por que" si no es obvio?
□ el build/tests pasan?
□ no hay archivos accidentales (.env, debug.log, .DS_Store)?
```

---

✅ aplica: historia_legible + revisiones_rapidas
