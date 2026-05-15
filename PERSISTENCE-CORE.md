# persistencia core (resumen activo)

> version compacta de PERSISTENCE.md. carga esta en `instructions`. consulta PERSISTENCE-DEEP.md bajo demanda.

## regla fundamental

**despues de cualquier operacion que modifique el proyecto, verifica consistencia antes de declarar terminado.**

## checklist minimo post-cambio

```
□ archivo(s) modificado(s) compilan sin error
□ imports apuntan a archivos existentes (ver [[js-module-validator]])
□ ningun consumidor del codigo cambiado quedo roto
□ documentacion / readme actualizada si la api cambio
□ tests del area afectada pasan
□ sin secretos hardcodeados (ver [[secrets-and-env]])
□ sin archivos accidentales (.env, debug.log, .DS_Store)
□ memoria actualizada si se aprendio algo persistente
```

## triggers que requieren verificacion deep

si tu cambio toca alguno de estos, consulta `PERSISTENCE-DEEP.md`:

- migraciones de base de datos
- cambios en autenticacion / autorizacion
- modificacion de contratos de api publicos
- refactor cruzando > 5 archivos
- cambio en pipelines de ml/ia
- actualizacion de dependencias mayores

## prohibido

- decir "listo" sin haber corrido la verificacion (ver [[verify-before-claim]])
- dejar imports rotos "los arreglo despues"
- ignorar warnings nuevos introducidos por el cambio
- saltarse el checklist por considerarlo "cambio pequeño"

---

✅ aplica: estado_consistente + cero_deuda_oculta
