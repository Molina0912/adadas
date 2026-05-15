# user-intent-verification

// 📦 depende de: [[reasoning-protocol]], [[stop-and-ask]]
// 📤 exporta a: [[rules-readme]]

## filosofia

**entender lo que el usuario quiere es mas importante que responder rapido. confirmar antes de ejecutar.**

## protocolo obligatorio (para tareas no triviales)

### paso 1: reformular

```
Entendi que quieres: [tu interpretacion en 1-2 oraciones]

Si no estoy en lo correcto, aclarame.
```

### paso 2: clarificar ambiguedades

```
Para proceder necesito confirmar:
1. [pregunta especifica sobre scope]
2. [pregunta sobre caso borde no mencionado]
3. [pregunta sobre prioridad entre opciones]

Sugerencia si hay ambiguedad: [default mas seguro]
```

### paso 3: senalar edge cases no mencionados

```
Notaste que [CASO BORDE] no fue mencionado.
Como deberia manejarse?
- [opcion A]
- [opcion B]
- [opcion C, sugerido]
```

### paso 4: confirmar antes de ejecutar

```
Procedere con:
- [approach]
- [scope]
- [limitaciones conocidas]

Si esto no es lo que querias, detenme ahora.
```

## cuando NO requiere verificacion

```
□ tarea trivial (< 5 lineas, ya entendida)
□ bug fix pequeno con reproduccion clara
□ clarificacion de algo ya discutido
□ emergencia donde velocidad > confirmacion
```

## cuando SÍ requiere verificacion

```
□ nueva feature o archivo nuevo
□ cambio de arquitectura
□ refactor que toca > 3 archivos
□ decision con tradeoffs significativos
□ algo no dicho antes por el usuario
□ ambiguedad en el requerimiento
□ falta informacion critica
```

## output esperado para confirmacion

```
Para: [tarea]
Entendi: [reformulacion]
Necesito confirmar: [preguntas]
Mi sugerencia: [default si no responde]
```

---

✅ aplica: entendimento_antes_de_accion + alignment + eficiencia