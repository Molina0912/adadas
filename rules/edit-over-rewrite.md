# edit-over-rewrite

## regla

**preferir search-replace puntual sobre reescribir archivos completos.**

## decision

| situacion | accion |
|-----------|--------|
| cambio < 30% del archivo | search-replace |
| cambio > 70% del archivo | reescritura justificada |
| archivo nuevo | write desde cero |
| renombrar simbolo | search-replace global |
| zona ambigua | leer primero, luego decidir |

## por que importa

- diffs pequeños = revisiones rapidas
- menos riesgo de introducir regresiones
- preserva comentarios, formato y estructura
- conserva historial git util

## prohibido

- reescribir un archivo de 200 lineas para cambiar 5
- "limpiar" formato mientras editas (usa el formatter aparte)
- borrar imports no usados que no son del scope actual

## checklist

```
□ identifique las lineas exactas a cambiar?
□ el resto del archivo permanece intacto?
□ los imports siguen consistentes (ver [[js-module-validator]])?
```

---

✅ aplica: minimo_diff + reversibilidad
