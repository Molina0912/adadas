# cognitive-loop

// 📦 depende de: [[zero-errors]], [[context-first]]
// 📤 exporta a: [[rules-readme]]

## filosofia

**nunca ejecutar directo. pensar antes de escribir.**

## loop obligatorio (8 pasos)

### paso 1: entender el objetivo

```
□ cual es el resultado final esperado?
□ quien lo va a usar?
□ cuando se considera exitoso?
□ cuales son las restricciones explicitas?
□ cuales son las restricciones implicitas?
```

### paso 2: inspeccionar el codebase

```
□ que archivos existen relacionados?
□ cual es la estructura del proyecto?
□ que convenciones sigue el proyecto?
□ que patrones estan establecidos?
□ cual es la arquitectura actual?
```

### paso 3: detectar restricciones

```
□ dependencias disponibles
□ breaking changes prohibidas
□ performance budget
□ backward compatibility
□ seguridad requerida
□ tests existentes
```

### paso 4: generar plan

```
□ archivos a crear/modificar
□ orden de cambios
□ puntos de no retorno
□ verificacion obligatoria
□ rollback si algo falla
```

### paso 5: verificar plan

```
□ el plan no viola [[domain-driven-boundaries]]?
□ el plan no introduce [[anti-side-effects]]?
□ el plan mantiene API contracts?
□ el plan es minimal (scope disciplined)?
□ hay alternativa mas simple que no consideré?
```

### paso 6: ejecutar

```
□ hacer cambios uno por uno
□ verificar cada cambio antes del siguiente
□ no improvisar durante ejecucion
□ si algo no coincide con plan -> detenerse y re-evaluar
```

### paso 7: verificar el cambio

```
□ compila sin errores?
□ tests pasan?
□ imports sincronizados (ver [[js-module-validator]])?
□ documentacion actualizada si corresponde?
□ regla [[verify-before-claim]]: evidencia ejecutada?
```

### paso 8: auditar resultado

```
□ correctitud: hace lo que se pidio?
□ seguridad: no introduce vulnerabilidades?
□ arquitectura: respeta boundaries?
□ performance: dentro del budget?
□ mantenibilidad: alguien mas puede mantenerlo?
```

## prohibiciones

```
□ ejecutar sin haber hecho paso 1-5
□ cambiar de opinion durante ejecucion sin re-planear
□ "esto debe funcionar" sin evidencia ejecutada
□ "ya lo arreglo despues" sin abrir issue
```

## cuando saltarse el loop

Para cambios menores de 5 lineas en archivos ya leidos:
- fix de typo
- comentario
- formateo

Para todo lo demas: **loop completo obligatorio.**

---

✅ aplica: pensamiento_antes_de_accion + disciplina_rigida + autonomia_disciplinada