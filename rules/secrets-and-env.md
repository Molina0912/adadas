# secrets-and-env

// 📦 depende de: [[zero-errors]] (seccion g - seguridad)

## regla

**ningun secreto en codigo. ningun secreto en logs. ningun secreto en commits.**

## prohibiciones absolutas

- hardcodear api keys, tokens, passwords, connection strings
- `console.log(process.env.SECRET)` o `echo $SECRET`
- commit de `.env`, `.env.local`, `credentials.json`, `*.pem`, `*.key`
- enviar secretos en query params (van a logs de servidor/proxy)
- compartir secretos en mensajes de chat o issues

## obligatorio

```
□ todo secreto vive en variable de entorno
□ existe .env.example con KEYS sin valores
□ .gitignore incluye .env*, !.env.example
□ validacion al arranque: throw si falta una key requerida
□ rotacion documentada en README
```

## validacion al arranque (ejemplo)

```ts
// env.ts
const required = ['DATABASE_URL', 'JWT_SECRET', 'API_KEY'] as const;
for (const key of required) {
  if (!process.env[key]) throw new Error(`missing env: ${key}`);
}
```

## redaccion en logs

cualquier logger debe enmascarar campos sensibles: `password`, `token`, `authorization`, `cookie`, `secret`, `key`, `ssn`, `credit_card`.

## si detectas un secreto expuesto

1. **detente**
2. avisa al usuario
3. recomienda rotar la credencial inmediatamente
4. propon mover a env var

---

✅ aplica: zero_trust + owasp_a02 + auditoria
