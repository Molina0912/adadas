# structured-logging-discipline

// 📦 depende de: [[logging-standards]], [[security-hardening]]
// 📤 exporta a: [[rules-readme]]

## formato obligatorio de logs

```json
{
  "timestamp": "2024-01-15T10:30:00.000Z",
  "level": "INFO",
  "module": "order-service",
  "function": "processOrder",
  "message": "order processed successfully",
  "context": {
    "orderId": "ord_123",
    "userId": "usr_abc"
  },
  "metrics": {
    "duration_ms": 150,
    "memory_mb": 45
  }
}
```

## campos obligatorios

| campo | descripcion |
|-------|------------|
| timestamp | ISO8601 |
| level | DEBUG, INFO, WARN, ERROR, FATAL |
| module | nombre del modulo |
| message | descripcion humana |
| context | datos relevantes (sin PII) |

## campos opcionales

| campo | descripcion |
|-------|------------|
| function | nombre de funcion |
| correlationId | para trazabilidad de requests |
| metrics | duration_ms, memory_mb, etc |

## prohibited

```
❌ console.log("debug") sin contexto estructurado
❌ Loggear datos sensibles sin ofuscar
❌ Silenciar errores con catch (e) {}
❌ Loggear passwords, tokens, emails completos
❌ Loggear stack traces en produccion sin sanitizar
```

## correct logging

```ts
// ✅ CORRECTO - logging estructurado
logger.info('order.processed', {
  orderId: order.id,
  userIdHash: hashUserId(user.id), // sin PII
  amount_cents: order.totalCents,
  duration_ms: elapsed
});

// ✅ CORRECTO - error con contexto
logger.error('order.failed', {
  orderId: order.id,
  error: e.message,
  stack: e.stack,
  duration_ms: elapsed
});
```

## redaction automatica

```ts
// ✅siempre enmascarar campos sensibles
const SENSITIVE_FIELDS = ['password', 'token', 'authorization', 'cookie', 'secret', 'key', 'ssn', 'credit_card'];

function redact(obj: any): any {
  const result: any = Array.isArray(obj) ? [] : {};
  for (const [key, value] of Object.entries(obj)) {
    if (SENSITIVE_FIELDS.some(f => key.toLowerCase().includes(f))) {
      result[key] = '[REDACTED]';
    } else if (typeof value === 'object' && value !== null) {
      result[key] = redact(value);
    } else {
      result[key] = value;
    }
  }
  return result;
}
```

---

✅ aplica: observabilidad + privacidad + debuggability