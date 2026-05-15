# api-contract-discipline

// 📦 depende de: [[zero-errors]], [[domain-driven-boundaries]]
// 📤 exporta a: [[rules-readme]]

## regla

**toda API publica debe tener: schema de input, schema de output, schema de errores.**

## cuando aplica

- endpoint HTTP (REST/GraphQL/gRPC)
- funcion exportada publica (mas de 1 consumidor)
- servicioIPC/mensajes
- eventos públicos

## schema obligatorio

### input schema

```ts
// para APIs HTTP: zod/valibot/schema en el endpoint
const CreateUserSchema = z.object({
  email: z.string().email(),
  name: z.string().min(1).max(100),
  role: z.enum(['admin', 'user']).default('user')
});

// para funciones exportadas: JSDoc + tipos
/**
 * @param {Object} input
 * @param {string} input.email
 * @param {string} input.name
 * @returns {Promise<User>}
 */
```

### output schema

```ts
// siempre documentar la forma del output
const UserResponseSchema = z.object({
  id: z.string().uuid(),
  email: z.string().email(),
  name: z.string(),
  createdAt: z.string().datetime()
});
```

### error schema

```ts
// siempre definir errores posibles
const CreateUserErrors = {
  EMAIL_TAKEN: { code: 'EMAIL_TAKEN', message: 'email ya existe' },
  VALIDATION_FAILED: { code: 'VALIDATION_FAILED', details: [...] },
  UNAUTHORIZED: { code: 'UNAUTHORIZED', message: 'no autenticado' }
};
```

## breaking changes (prohibido sin migracion)

```
□ no eliminar campos de response (añadir nullable o nuevo campo)
□ no cambiar tipo de campo (añadir validacion + backward compat)
□ no cambiar status codes establecidos
□ no hacer required un campo que era optional
□ no renombrar endpoints sin deprecar el anterior
```

## checklist

```
□ toda API publica tiene input schema?
□ toda API publica tiene output schema?
□ toda API publica tiene error schema definido?
□ los cambios fueron revisados por breaking changes?
□ existe backward compatibility o migracion documentada?
□ se usaron zod/valibot/JSON schema para validar?
```

## validacion automatica

```
□ se valida input con zod/valibot antes de procesar?
□ se valida output antes de retornar?
□ se retornan errores con schema definido (no throw generico)?
□ los errores 500 no exponen internals al cliente?
```

---

✅ aplica: contratos_explicitos + backward_compat + seguridad_tipos