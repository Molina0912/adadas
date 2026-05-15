# observability-by-design

// 📦 depende de: [[logging-standards]], [[structured-logging-discipline]], [[performance-awareness]]
// 📤 exporta a: [[rules-readme]]

## filosofia

**metrics, logs y traces desde el primer commit. no anadidos depois como afterthought.**

## los 3 pilares

### 1. metrics (numeros)

```ts
// ✅ Metrics desde el inicio
const httpRequestDuration = new Histogram({
  name: 'http_request_duration_ms',
  help: 'Duration of HTTP requests',
  labelNames: ['method', 'route', 'status']
});
```

### 2. logs (contexto)

```ts
// ✅ Logs estructurados con correlation ID
logger.info('request.completed', {
  correlationId: req.id,
  method: req.method,
  route: req.route,
  duration_ms: elapsed,
  status: res.status
});
```

### 3. traces (trazabilidad completa)

```ts
// ✅ Traceo de requests completos
const span = tracer.startSpan('order.process');
span.setAttributes({ orderId: order.id });
// ... operations ...
span.end();
```

## correlation ID obligatorio

```
Todo request debe tener un correlationId unico:
- Generado en el entry point (API Gateway o middleware)
- Pasado a traves de todo el call stack
- Incluido en todos los logs y metrics
- Presente en respuestas de error
```

## health checks

```ts
// ✅ Health check endpoint
app.get('/health', async (req, res) => {
  const checks = {
    db: await checkDatabase(),
    redis: await checkRedis(),
    external: await checkExternal()
  };
  const healthy = Object.values(checks).every(c => c.healthy);
  res.status(healthy ? 200 : 503).json({
    status: healthy ? 'healthy' : 'unhealthy',
    checks,
    uptime: process.uptime()
  });
});
```

## alerting basico

```ts
// ✅ Alertas para degradation
if (errorRate > 0.05) {
  logger.warn('error_rate_high', { rate: errorRate, threshold: 0.05 });
}
if (p99Latency > 1000) {
  logger.warn('latency_high', { p99_ms: p99Latency, threshold: 1000 });
}
```

## checklist

```
□ todo endpoint tiene correlationId?
□ todo log incluye timestamp, level, module, correlationId?
□ metrics de latencia, error rate, throughput?
□ health check endpoint implementado?
□ alerts configurados para thresholds criticos?
□ tracing distribuido para microservicios?
```

---

✅ aplica: observabilidad_desde_inicio + debuggabilidad + alertas_proactivas