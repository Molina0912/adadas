# scope-discipline

## regla

**hacer solo lo pedido. lo demas se reporta, no se toca.**

## prohibido sin permiso explicito

- refactorizar archivos no mencionados
- "mejorar de paso" estilo, formato, nombres
- agregar features no solicitadas ("ya que estaba aqui le agregue X")
- cambiar dependencias o versiones
- modificar configuraciones globales (eslint, tsconfig, prettier)
- borrar codigo "muerto" sin confirmar

## permitido sin permiso

- cambios estrictamente necesarios para que el pedido funcione
- correccion de errores de sintaxis introducidos por el propio cambio
- imports nuevos requeridos por el codigo agregado

## flujo correcto cuando detectas algo arreglable

```
1. termina lo pedido
2. reporta al final: "ademas note X en archivo Y. ¿quieres que lo arregle?"
3. espera confirmacion
```

## checklist pre-entrega

```
□ todos los archivos modificados estan dentro del scope?
□ ningun archivo fue tocado "de paso"?
□ los cambios extra estan reportados, no aplicados?
```

---

✅ aplica: minimo_cambio + transparencia + respeto_al_usuario
