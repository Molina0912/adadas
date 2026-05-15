# performance-awareness

// 📦 depende de: [[zero-errors]], [[database-performance.md]], [[performance-budgets]]
// 📤 exporta a: [[rules-readme]]

## filosofia

**antes de implementar, evaluar complejidad algoritmica. si es O(n^2) o peor,优化的 antes de escribir codigo.**

## evaluacion obligatoria

### complejidad temporal

```
□ loops anidados -> O(n^2) minimo
□ loop dentro de loop dentro de loop -> O(n^3)
□ recursion sin memoizacion -> stack overflow potencial
□ operaciones en arrays grandes -> O(n log n) minimo
```

### complejidad espacial

```
□ crear arrays copy en cada iteracion -> O(n) espacio extra
□ cargar todo en memoria de una vez -> memory leak potencial
□ guardar cache sin limite -> unbounded memory growth
```

## checklist pre-implementacion

```
□ cual es el tamanio de entrada esperado?
□ que pasaria si es 10x mayor?
□ que pasaria si es 100x mayor?
□ hay N+1 queries en este codigo?
□ se puede usar indices en las queries?
□ hay render innecesario en cada keystroke?
□ se cachea lo que no debe cambiar?
```

## senales de alerta

```
ALTO: loops anidados sobre datasets grandes
ALTO: queries sin index en filtros
ALTO: recursion sin tail optimization
ALTO: objetos grandes en estado de React
MEDIO: operaciones O(n^2) sobre arrays grandes
MEDIO: falta de pagination en listados
MEDIO: memory allocation en render loops
```

## optimizaciones comunes

```ts
// ❌ N+1 query
for (const user of users) {
  const orders = await db.query(`SELECT * FROM orders WHERE user_id = ${user.id}`);
}

// ✅ Optimizado
const orders = await db.query('SELECT * FROM orders WHERE user_id IN ($1)', [users.map(u => u.id)]);
const ordersByUser = new Map(orders.map(o => [o.user_id, o]));
// ahora O(1) lookup
```

```ts
// ❌ render en cada input
<input onChange={(e) => setValue(e.target.value)} />

// ✅ con debounce
const debouncedSetValue = useDebouncedCallback(setValue, 300);
<input onChange={(e) => debouncedSetValue(e.target.value)} />
```

```ts
// ❌ array copy en recursion
function recurse(arr) {
  return arr.map(x => recurse(arr.filter(y => y.parent === x))); // cada filter re-crea array
}

// ✅ con memoizacion
const memo = new Map();
function recurseWithMemo(arr, id) {
  if (memo.has(id)) return memo.get(id);
  const result = compute(arr, id);
  memo.set(id, result);
  return result;
}
```

---

✅ aplica: big_o_awareness + no_premature_optimization + no_pessimization