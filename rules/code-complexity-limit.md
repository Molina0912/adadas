# code-complexity-limit

// 📦 depende de: [[zero-errors]], [[reasoning-protocol]]
// 📤 exporta a: [[rules-readme]]

## regla

**nunca crear funciones con complejidad ciclomatica > 10.**

## metricas

| tipo | maximo |
|------|--------|
| if/else anidados | 3 niveles |
| switch cases | 5 casos |
| bucles anidados | 2 niveles |
| callbacks anidados | 2 niveles |
| parametros por funcion | 4 |
| profundidad de recursion | 3 |

## checklist

```
□ if/else anidados > 3 niveles -> refactorizar a early return
□ switch con > 5 casos -> considerar strategy pattern
□ bucles anidados > 2 niveles -> extraer a funcion helper
□ callbacks anidados > 2 niveles -> usar async/await
□ complejidad ciclomatica > 10 -> dividir en funciones pequenas
□ funcion > 30 lineas -> dividir (ver [[zero-errors]])
```

## patrones para reducir complejidad

### early return (reduce anidamiento)

```ts
// ❌ ALTA COMPLEJIDAD - anidamiento profundo
function processUser(user: User | null) {
  if (user) {
    if (user.active) {
      if (user.role === 'admin') {
        // logica
      }
    }
  }
}

// ✅ BAJA COMPLEJIDAD - early returns
function processUser(user: User | null) {
  if (!user) return;
  if (!user.active) return;
  if (user.role !== 'admin') return;
  // logica
}
```

### strategy pattern (reemplaza switch largo)

```ts
// ❌ SWITCH LARGO
function calculate(type: string, data: Data) {
  switch (type) {
    case 'a': return calcA(data);
    case 'b': return calcB(data);
    case 'c': return calcC(data);
    // ...mas casos
  }
}

// ✅ STRATEGY
const strategies = {
  a: calcA,
  b: calcB,
  c: calcC,
};

function calculate(type: string, data: Data) {
  const fn = strategies[type];
  if (!fn) throw new Error(`Unknown type: ${type}`);
  return fn(data);
}
```

### extract helper (reduce tamano)

```ts
// ❌ FUNCION LARGA
function processOrder(order: Order) {
  // 50 lineas de logica
}

// ✅ FUNCIONES PEQUENAS
function processOrder(order: Order) {
  const validated = validateOrder(order);
  const calculated = calculateTotals(validated);
  return persistOrder(calculated);
}
```

## verificacion automatica

```bash
# eslint
npx eslint --rule 'complexity: [error, 10]' .

# radon (python)
radon cc -a -m 10 .
```

Si complexity > 10: **DETENER y refactorizar antes de continuar.**

---

✅ aplica: complejidad_controlada + legibilidad + testabilidad