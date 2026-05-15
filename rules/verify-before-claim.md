# verify-before-claim

// 📦 depende de: [[zero-errors]], [[error-recovery]]

## regla

**no decir "listo / arreglado / funciona" sin evidencia ejecutada.**

## señales validas de verificacion

| cambio | señal minima |
|--------|--------------|
| logica nueva | test unitario que pasa |
| bug fix | test que reproduce el bug ahora pasa |
| endpoint | `curl` con respuesta esperada |
| build/config | `build` exitoso |
| ui | screenshot o inspeccion manual descrita |
| schema/migracion | aplicada y consultada |
| refactor | suite completa sigue verde |

## frases prohibidas sin evidencia

- "ya quedo arreglado"
- "deberia funcionar"
- "listo"
- "lo implemente correctamente"

## frases permitidas cuando no se puede verificar

- "implemente X. no pude ejecutar Y porque [razon]. para validar corre: [comando]"
- "el cambio compila pero no probe el caso Z; recomiendo agregar test"

## checklist final

```
□ corri la verificacion mas barata aplicable?
□ si fallo, lo digo explicitamente?
□ si no pude verificar, lo digo explicitamente?
```

---

✅ aplica: honestidad_tecnica + evidencia_obligatoria
