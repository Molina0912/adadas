# security-hardening

// 📦 depende de: [[zero-errors]], [[secrets-and-env]]
// 📤 exporta a: [[rules-readme]]

## regla

**default deny. todo lo inseguro esta prohibido a menos que este explicitamente justificado.**

## OWASP Top 10 - prohibitions absolutas

### A01 - Injection (SQL/NoSQL)

```ts
// ❌ PROHIBIDO - sql injection
const query = `SELECT * FROM users WHERE id = ${userId}`;

// ✅ CORRECTO - prepared statements
const result = await db.query('SELECT * FROM users WHERE id = $1', [userId]);
```

### A02 - Broken Authentication

```ts
// ❌ PROHIBIDO - passwords sin hash
await db.query(`INSERT INTO users (pass) VALUES ('${password}')`);

// ✅ CORRECTO - bcrypt/argon2
const hashed = await bcrypt.hash(password, 12);
```

### A03 - Sensitive Data Exposure

```ts
// ❌ PROHIBIDO - secrets en codigo
const apiKey = 'sk_live_123456789';

// ❌ PROHIBIDO - secrets en logs
logger.info('user login', { password: user.password });

// ✅ CORRECTO - solo en env, nunca en logs
const apiKey = process.env.STRIPE_API_KEY;
```

### A04 - XML External Entities (XXE)

```ts
// ❌ PROHIBIDO - parseo XML inseguro
const parser = new xml.Parser({ externalEntities: true });

// ✅ CORRECTO - configuracion segura
const parser = new xml.Parser({ externalEntities: false });
```

### A05 - Broken Access Control

```ts
// ❌ PROHIBIDO - falta autorizacion
app.get('/admin/users', (req, res) => { ... });

// ✅ CORRECTO - con middleware de auth + verify-ownership
app.get('/admin/users', authMiddleware, requireAdmin, handler);
```

### A06 - Security Misconfiguration

```ts
// ❌ PROHIBIDO - cors permisivo
app.use(cors({ origin: '*' }));

// ✅ CORRECTO - cors restringido
app.use(cors({ origin: ['https://app.example.com'], credentials: true }));
```

### A07 - XSS (Cross-Site Scripting)

```ts
// ❌ PROHIBIDO - innerHTML/dangerouslySetInnerHTML sin sanitizar
element.innerHTML = userInput;

// ✅ CORRECTO - sanitizar con DOMPurify
element.innerHTML = DOMPurify.sanitize(userInput, { ALLOWED_TAGS: ['b', 'i'] });
```

### A08 - Insecure Deserialization

```ts
// ❌ PROHIBIDO - deserializacion insegura
const obj = JSON.parse(untrustedData); // solo si data es trusted

// ❌ PROHIBIDO - eval/Function
const fn = new Function('return ' + code);

// ✅ CORRECTO - schema validation + no eval
const validated = SafeParse.parse(untrustedData, Schema);
```

### A09 - Using Components with Known Vulnerabilities

```ts
// ❌ PROHIBIDO - dependencia sin audit
// ✅ CORRECTO - npm audit && renovacion activa
```

### A10 - Insufficient Logging & Monitoring

```ts
// ❌ PROHIBIDO - errores silenciosos
catch (e) {}

// ✅ CORRECTO - logging estructurado
catch (e) { logger.error('payment.failed', { error: e.message, orderId }); }
```

## checklist de seguridad

```
□ ninguna sentencia SQL dinámica sin prepared statements?
□ ninguna contraseña sin hash (bcrypt/argon2)?
□ ninguna API expuesta sin autenticación/autorización?
□ ningun innerHTML/dangerouslySetInnerHTML sin sanitización?
□ ningun eval(), new Function() con input de usuario?
□ ningun secret hardcoded en código o logs?
□ ningun CORS con origin: '*'?
□ ninguna deserialización de datos no confiados?
□ ningun console.log de datos sensibles?
```

## verification command

```bash
npm audit
```

---

✅ aplica: owasp_top10 + default_deny + zero_trust