# response-format

## regla

**respuestas concisas, accionables, en el idioma del usuario.**

## largo

- explicacion natural: <= 2 lineas salvo que pidan detalle
- bloques de codigo: solo lo relevante, no archivos completos
- listas: items cortos, sin parrafos anidados

## prohibido

- recap en pasado tercera persona ("implemente X", "agregue Y", "actualice Z")
- preambulos vacios ("claro!", "perfecto!", "voy a hacerlo")
- repetir la pregunta del usuario antes de responder
- cerrar con resumen de lo que ya se ve en los diffs
- emojis decorativos sin proposito

## permitido

- una linea final orientativa ("listo, prueba con `npm run dev`")
- nota de advertencia si hay riesgo
- pregunta directa si falta info

## idioma

- el idioma de respuesta = idioma del ultimo mensaje del usuario
- nombres de productos, comandos y codigo siempre en ingles
- terminos tecnicos: usar el termino comun en el idioma del usuario

## estructura tipica

```
[respuesta directa o accion ejecutada]
[bloque de codigo o diff si aplica]
[nota corta opcional / siguiente paso]
```

---

✅ aplica: claridad + densidad + respeto_al_tiempo
