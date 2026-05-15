# agent-self-assessment

// 📦 depende de: [[zero-errors]], [[reasoning-protocol]], [[cognitive-loop]]
// 📤 exporta a: [[rules-readme]]

## filosofia

**antes de entregar cualquier respuesta, auto-evaluarse rigidamente.**

## checklist de auto-evaluacion

```
□ ¿Mi respuesta sigue el protocolo de 5 fases? [S/N]
□ ¿Verifiqué todos los límites de [[zero-errors]]? [S/N]
  - archivo < 150 lineas?
  - funcion < 30 lineas?
  - imports < 10?
□ ¿Consulté documentación MCP si era relevante? [S/N]
□ ¿Mi nivel de confianza coincide con la complejidad? [Alto/Medio/Bajo]
□ ¿Incluí warnings si hay incertidumbre? [S/N]
□ ¿La respuesta es concisa y accionable? [S/N]
□ ¿Seguí [[response-format]] (sin preambulos, sin recap)? [S/N]
□ ¿Verifiqué con [[verify-before-claim]] antes de claim? [S/N]
```

## senales de detenerse

Si cualquier respuesta es **N** o el nivel es **Bajo**:
- DETENER
- pedir clarificacion al usuario
- o reportar incertidumbre explicitamente

## niveles de confianza

| nivel | cuando usar | accion |
|-------|------------|--------|
| alto | contexto claro, tarea simple, reglas conocidas | ejecutar directo |
| medio | contexto parcial, ambiguedad menor | ejecutar con warnings |
| bajo | informacion insuficiente, riesgo de violar regla | stop-and-ask |

## output esperado si hay duda

```
No tengo suficiente contexto para responder con confianza.
Necesito clarificar:
1. [pregunta especifica]
2. [pregunta especifica]
3. [pregunta especifica]

Sugerencia: [default razonable si el usuario quiere continuar]
```

## ejemplo de auto-evaluacion

```
Respuesta planificada:
- modificar archivo X para agregar feature Y
- estimado: 20 lineas, 1 archivo
- confianza: alto
- reglas aplicables: zero-errors, scope-discipline
- verificacion: compilacion local

Auto-check:
□ zero-errors: archivo < 150 lineas ✅, funcion < 30 lineas ✅
□ scope: solo 1 archivo, dentro del scope ✅
□ MCP: no necesario para esta tarea ✅
□ confidence: alto ✅

Resultado: PROCEDER
```

---

✅ aplica: auto-disciplina + calidad_sin_compasion + transparencia