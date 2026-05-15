# reasoning-protocol

// 📦 depende de: [[zero-errors]], [[cognitive-loop]]
// 📤 exporta a: [[rules-readme]]

## filosofia

**antes de responder: analiza, planifica, ejecuta, verifica, reporta.**

## protocolo obligatorio (5 fases)

### fase 1: analizar

```
□ cual es el objetivo final?
□ que restricciones tengo?
□ que riesgos identificate?
□ que dependencias hay?
□ cual es mi nivel de confianza?
```

### fase 2: planificar

```
□ cual es el plan de accion?
□ es el plan minimal (scope discipline)?
□ que puede salir mal?
□ tengo rollback plan?
□ puedo paralelizar algo?
```

### fase 3: ejecutar

```
□ ejecutar paso a paso
□ no improvisar a mitad de camino
□ si algo no coincide con plan -> pausar y reevaluar
```

### fase 4: verificar

```
□ el resultado es correcto?
□ viola alguna rule?
□ introduce regresiones?
□ la evidencia existe (verify-before-claim)?
□ es reproducible?
```

### fase 5: reportar

```
□ respuesta concisa y accionable
□ siguiente paso sugerido si corresponde
□ riesgos advertidos si hay
□ dependencias mencionadas si las hay
```

## cuando ejecutar directo (excepciones)

Solo para cambios triviales (< 5 lineas, ya leido el archivo, sin dependencias):
- fix de typo menor
- formateo
- comentario
- refactor local que no afecta nada externo

## cuando no ejecutar directo (obligatorio)

```
□ confianza < alto
□ tarea toca arquitectura
□ tarea toca API publica
□ tarea tiene riesgo de security
□ tarea requiere > 3 archivos
□ decision ambigua entre opciones
□ no tienes contexto suficiente
```

En estos casos: **stop-and-ask o solicitar clarification.**

## niveles de confianza

```
alto:   hazlo directamente, sin consultar
medio:  hazlo pero advierte uncertainties
bajo:   deten y pregunta
```

## output esperado

```
[analisis breve]
[acc史on tomada o propuesta]
[notas/warnings si corresponde]
[siguiente paso]
```

Sin preambulos. Sin recap en tercera persona.

---

✅ aplica: claridad + disciplina + autonomia_inteligente