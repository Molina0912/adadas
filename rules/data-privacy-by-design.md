# data-privacy-by-design

// 📦 depende de: [[security-hardening]], [[secrets-and-env]], [[logging-standards]]
// 📤 exporta a: [[rules-readme]]

## regla

**nunca procesar datos personales sin anonimizacion/pseudonimizacion explícita.**

## clasificacion de datos

| tipo | ejemplo | tratamiento |
|------|---------|-------------|
| PII | email, telefono, nombre | hash/tokenizar en logs |
| Sensitive | SSN, tarjeta credito | nunca en logs, cifrado obligatorio |
| Quasi-identifier | IP, device ID | pseudonimizar si se comparte |
| Aggregated | estadisticas | generalmente seguro |

## checklist obligatorio

```
□ el dato es PII? -> aplicar hash SHA-256 antes de loggear
□ se envia a externo? -> verificar consentimiento y minimizacion
□ se almacena? -> definir TTL y politica de borrado
□ se usa en IA/analytics? -> documentar proposito y base legal
□ datos de produccion usados en dev/test? -> usar data anonimizada
```

## prohibited

```ts
// ❌ INCORRECTO - PII en logs
logger.info('user login', { email: user.email });

// ❌ INCORRECTO - PII en logs
logger.info('request', { ip: req.ip, userAgent: req.get('User-Agent') });

// ❌ INCORRECTO - datos crudos a terceros
await fetch('/api/analytics', { body: { email: user.email, name: user.name } });

// ❌ INCORRECTO - datos de produccion en dev
const users = db.query('SELECT * FROM production_users LIMIT 10');
```

## correcto

```ts
// ✅ CORRECTO - hash para logs
const emailHash = crypto.createHash('sha256').update(user.email).digest('hex');
logger.info('user login', { emailHash: emailHash.substring(0, 8) });

// ✅ CORRECTO - IP parcial para logs
logger.info('request', { ip: req.ip.split('.').slice(0, 2).join('.') + '.x.x' });

// ✅ CORRECTO - datos agregados/anonimizados
await fetch('/api/analytics', {
  body: { region: 'US-CA', ageRange: '25-35', anonymizedId: generatePseudoId() }
});
```

## data anonymization helpers

```ts
// ✅ helpers de anonimizacion
export function hashEmail(email: string): string {
  return crypto.createHash('sha256').update(email.toLowerCase()).digest('hex').substring(0, 8);
}

export function partialIp(ip: string): string {
  const parts = ip.split('.');
  return parts.slice(0, 2).map(() => 'x').join('.') + '.x.x';
}

export function anonymizeUser(user: User): AnonymizedUser {
  return {
    id: user.id,
    emailHash: hashEmail(user.email),
    region: user.region,
    accountAgeDays: Math.floor((Date.now() - user.createdAt) / 86400000)
  };
}
```

## retention policy

```ts
// ✅ TTL obligatorio en datos personales
const PERSONAL_DATA_TTL_DAYS = 365;
const SENSITIVE_DATA_TTL_DAYS = 30;

async function scheduleDeletion(userId: string) {
  const deleteAt = new Date(Date.now() + SENSITIVE_DATA_TTL_DAYS * 86400000);
  await db.jobs.create({ type: 'DELETE_USER_DATA', userId, executeAt: deleteAt });
}
```

---

✅ aplica: gdpr_compliance + privacy_by_design + data_minimization