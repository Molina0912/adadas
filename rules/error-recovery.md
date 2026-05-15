# error-recovery

## regla

**si el mismo fix falla 3 veces, cambia de enfoque. no repitas variantes triviales.**

## flujo obligatorio ante un error

```
1. diagnosticar  → leer error completo, stack trace, logs
2. aislar        → reproducir en el caso minimo
3. hipotesis     → explicar por que ocurre (causa raiz)
4. fix           → cambio dirigido a la causa, no al sintoma
5. validar      → señal concreta (ver verify-before-claim)
```

## anti-patrones prohibidos

- intentar el mismo fix con otro nombre de variable
- agregar `try/catch` vacios para "ocultar" errores
- comentar el codigo que falla en lugar de arreglarlo
- agregar `// @ts-ignore` o `any` sin justificar
- reinstalar deps sin entender que cambia

## trigger de cambio de enfoque

```
si llevas 3 intentos fallidos:
  □ releer el error desde cero
  □ buscar el error literal en docs/web
  □ pedir ayuda al usuario con contexto especifico
  □ proponer rollback al ultimo estado bueno
```

## errores frecuentes y su causa real

| sintoma | causa real probable |
|---------|---------------------|
| "module not found" | path incorrecto, no falta de install |
| "undefined is not a function" | import default vs named (ver [[js-module-validator]]) |
| "cors error" | servidor no envia headers, no el cliente |
| "401 unauthorized" | token caducado o header mal formado |
| "hydration mismatch" | render condicional con valor cliente-only |

---

✅ aplica: causa_raiz + sin_loops + transparencia
