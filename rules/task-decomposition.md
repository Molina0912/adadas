# task-decomposition

// 📦 depende de: [[zero-errors]], [[cognitive-loop]]
// 📤 exporta a: [[rules-readme]]

## regla

**si tarea > 2 archivos: mapear, planear, ejecutar, verificar.**

## cuando aplica

```
□ tarea toca 3+ archivos
□ tarea involucra multiples modulos
□ tarea requiere cambios en API publica
□ tarea introduce nueva dependencia
□ tarea modifica arquitectura existente
□ tarea afecta tests de multiples modulos
```

## decomposition template

### fase 1: mapeo

```
archivos involucrados:
- [archivo1]: responsabilidad X, dependencias Y
- [archivo2]: responsabilidad X, dependencias Y

impacto estimado:
- [area1]: [alto/medio/bajo]
- [area2]: [alto/medio/bajo]
```

### fase 2: plan

```
orden de cambios:
1. [cambio 1] -> archivos [lista]
2. [cambio 2] -> archivos [lista]
3. ...

puntos de verificacion:
- [ ] cambio 1 compila/funciona antes de continuar
- [ ] cambio 2 compila/funciona antes de continuar

rollback si falla en paso N:
- archivos a revertir: [lista]
- comando: git checkout [files]
```

### fase 3: ejecucion

```
[[checkpoint]] inicio: [timestamp]
[[checkpoint]] cambio 1 done: [timestamp]

ejecutar en orden. no saltar pasos.
```

### fase 4: verificacion

```
□ compilacion exitosa?
□ tests pasan?
□ integration test si corresponde?
□ documento actualizado?
□ breaking changes revisadas?
```

## signals para detenerse

```
□ cambio requiere > 10 archivos
□ cambio toca > 3 dominios diferentes
□ cambio rompe backwards compatibility
□ sin tests para nueva feature
□ performance degrades noticeably
```

En estos casos: **detenerte y reportar antes de continuar.**

---

✅ aplica: complejidad_controlada + rollback_seguro + transparencia