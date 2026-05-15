# regression-enforcement

// 📦 depende de: [[zero-errors]], [[test-pyramid]]
// 📤 exporta a: [[rules-readme]]

## filosofia

**todo bug corregido debe tener regression test. obligatoriamente.**

## template para bug fix

```
## bug: [titulo breve]
fecha: YYYY-MM-DD
severity: [critico | alto | medio | bajo]

## reproduccion
[pasos exactos para reproducir]

## causa raiz
[por que ocurre]

## fix aplicado
[que se cambio]

## regression test
[test que verifica el fix y evita recurrence]
```

## checklist

```
□ el bug fue reproducible antes del fix?
□ la causa raiz fue identificada (no solo el sintoma)?
□ el fix aborda la causa raiz?
□ existe regression test para este bug especifico?
□ el test fallaba antes del fix y pasa ahora?
□ el test cubrira el caso si alguien hace refactor?
```

## regression test examples

### unit test

```ts
it('should not throw when user.id is null', () => {
  const result = formatUser({ id: null, name: 'Test' });
  expect(result).toBeDefined();
});

it('should handle empty array in sortUsers', () => {
  const result = sortUsers([]);
  expect(result).toEqual([]);
});
```

### integration test

```ts
it('should return 400 when email already exists', async () => {
  await createUser({ email: 'test@example.com' });
  const res = await createUser({ email: 'test@example.com' });
  expect(res.status).toBe(400);
  expect(res.body.code).toBe('EMAIL_TAKEN');
});
```

## prohibido

```
□ arreglar bug sin regression test
□ regression test que no falla antes del fix
□ regression test que no cubre el caso especifico
□ marcar como "no reproduction possible" sin evidencia
```

---

✅ aplica: calidad_sostenida + no_regresion + deuda_tecnica_controlada