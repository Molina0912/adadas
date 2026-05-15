# context-window-management

// 📦 depende de: [[memory-discipline]], [[cognitive-loop]]
// 📤 exporta a: [[rules-readme]]

## filosofia

**manejar el contexto como recurso limitado y valioso. cuando se llena, resumir y priorizar.**

## senales de contexto lleno

```
□ la respuesta empieza a repetir informacion previa
□ el modelo hace referencia a cosas del "pasado lejano" en la conversacion
□ las instrucciones mas recientes parecen no aplicar
□ el codigo generado no coincide con lo solicitado hace pocas respuestas
□ errores de "context length exceeded"
```

## estrategias de conservacion

### 1. resumen incremental

Cuando el historial supere 15-20turns:

```
"Resumiendo conversacion hasta ahora:
- objetivo: [descripcion breve]
- progreso: [que se hizo]
- pendiente: [que falta]
- restricciones: [limits, no-go areas]
Continuare desde aqui."
```

### 2. priorizacion de contexto

```
PRIORIDAD ALTA (siempre mantener):
- archivo actual y imports directos
- restricciones del proyecto
- ultima instruccion del usuario
- contexto de la tarea en curso

PRIORIDAD MEDIA (resumir si ocupa mucho):
- decisiones arquitecturales previas
- historial de cambios
- convenciones establecidas

PRIORIDAD BAJA (descartar o resumir mucho):
- mensajes de debugging
- tentativos fallidos
- informacion redundante
```

### 3. checkpoints

Para tareas largas (> 10 pasos):

```
[[checkpoint]] checkpoint 1: objetivos confirmados
[[checkpoint]] checkpoint 2: mapeo completo
[[checkpoint]] checkpoint 3: implementacion parcial X% 
```

### 4. limpieza proactiva

```
□ despues de cada tarea completada: limpiar contexto de esa tarea
□ al cambiar de archivo/ modulo:resetear contexto local
□ al terminar seccion: resumir yarchivar
```

## alert threshold

```
□ contexto > 80% utilizado -> avisar al usuario
□ contexto > 95% utilizado -> sugerir compactacion o nueva sesion
□ error de context length -> stop y resumir todo antes de continuar
```

## resumen post-tarea

```
Tarea completada: [breve descripcion]
Archivos tocados: [lista]
Decision importante: [si hubo alguna]
Siguiente paso sugerido: [si aplica]
```

---

✅ aplica: contexto_limpiado + no_repetir + eficiencia