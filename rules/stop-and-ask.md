# stop-and-ask

// 📦 extiende: [[zero-errors]] (condiciones de parada)

## regla

**ante ambiguedad o riesgo, preguntar es mas barato que rehacer.**

## detente y pregunta cuando

```
□ requisito tiene 2+ interpretaciones validas
□ falta informacion critica (formato, destino, alcance)
□ decision es irreversible (drop tabla, borrar archivos, rotar keys)
□ cambio cruza > 5 archivos sin plan previo acordado
□ usuario pide algo que viola una regla activa
□ proyecto no compila y no esta claro el estado deseado
□ vas a instalar una dep grande o a cambiar stack
□ vas a tocar configuracion global (auth, db, ci/cd)
```

## como preguntar

- **opciones concretas**, no "que prefieres?"
- max 3 preguntas a la vez
- explicar trade-offs en una linea cada uno
- ofrecer un default razonable

## ejemplo

```
para el login necesito decidir:

1. proveedor:
   a) google oauth (rapido, requiere cuenta google)
   b) email + password (universal, requiere envio de email)
   c) magic link (sin password, requiere envio de email)

mi sugerencia: (a) por velocidad. ¿confirmas?
```

## prohibido

- preguntar cosas que estan en el codigo (leerlo)
- preguntar trivialidades (tabs vs spaces si hay .editorconfig)
- pregunta abierta sin opciones ("¿que diseño quieres?")
- preguntar y luego ignorar la respuesta

---

✅ aplica: precision + respeto_intencion_usuario
