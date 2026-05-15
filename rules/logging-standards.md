# logging-standards

## regla

**logs estructurados, niveles correctos, sin pii.**

## niveles

| nivel | cuando usar |
|-------|-------------|
| debug | solo desarrollo, deshabilitado en prod |
| info | eventos normales (request recibido, job completado) |
| warn | algo raro pero recuperable (retry, fallback) |
| error | falla que requiere atencion |
| fatal | el proceso no puede continuar |

## obligatorio

- logs en backend en formato json (key-value)
- incluir `timestamp`, `level`, `correlation_id`, `module`
- redaccion automatica de campos sensibles (ver [[secrets-and-env]])
- sin `console.log` en codigo de produccion (usa logger del proyecto)

## prohibido

- `console.log("aqui")`, `console.log("xxxx")` o emoji-debug en commits
- loggear objetos completos sin filtrar (`req`, `user`, `session`)
- loggear secretos, tokens, passwords, tarjetas, ssn
- silenciar errores con `catch {}`

## ejemplo correcto (backend)

```ts
logger.info('order.created', {
  order_id: order.id,
  user_id: order.userId,
  amount_cents: order.totalCents,
  // NO: card_number, NO: email completo
});
```

## ejemplo correcto (frontend)

```ts
// solo en desarrollo
if (import.meta.env.DEV) {
  console.debug('[checkout] step', step);
}
```

---

✅ aplica: observabilidad + privacidad + debuggability
