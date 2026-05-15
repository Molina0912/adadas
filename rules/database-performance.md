# database-performance

// 📦 depende de: [[zero-errors]], [[security-hardening]], [[performance-awareness]]
// 📤 exporta a: [[rules-readme]]

## filosofia

**toda query debe tener indice, paginacion y ser minima. nunca select * en produccion.**

## reglas de oro

```
1. indexes en columnas de WHERE, JOIN, ORDER BY
2. paginacion en TODO listado (max 50 por defecto)
3. select solo columnas necesarias (no SELECT *)
4. nunca queries en serie cuando pueden ser paralelas
5. EXPLAIN ANALYZE antes de deployar queries complejas
```

## checklist de query

```
□ esta query tiene indices en todas las columnas filtradas?
□ tiene paginacion con LIMIT/OFFSET?
□ usa solo las columnas necesarias (no *)?
□ no tiene N+1 (verifica con logs de query)?
□ no hace LIKE '%pattern%' en columnas indexadas?
□ no hace subqueries correlateadas si puede usar JOIN?
```

## N+1 detection

```ts
// ❌ N+1
const users = await db.query('SELECT * FROM users LIMIT 100');
for (const user of users) {
  user.orders = await db.query(`SELECT * FROM orders WHERE user_id = ${user.id}`);
}
// 1 + 100 queries = N+1 problem

// ✅ Optimizado
const users = await db.query('SELECT * FROM users LIMIT 100');
const userIds = users.map(u => u.id);
const orders = await db.query(
  'SELECT * FROM orders WHERE user_id IN ($1)', 
  [userIds]
);
// 2 queries total
```

## pagination

```ts
// ❌ Sin paginacion
const allUsers = await db.query('SELECT * FROM users');

// ✅ Con paginacion
const PAGE_SIZE = 50;
const page = Math.max(1, parseInt(pageParam) || 1);
const offset = (page - 1) * PAGE_SIZE;
const users = await db.query(
  'SELECT id, email, name, created_at FROM users ORDER BY id LIMIT $1 OFFSET $2',
  [PAGE_SIZE, offset]
);
```

## index exemplo

```sql
-- Crear indice para фильтros y JOINs frecuentes
CREATE INDEX CONCURRENTLY idx_orders_user_id ON orders(user_id);
CREATE INDEX CONCURRENTLY idx_orders_created_at ON orders(created_at DESC);

-- Composite index para queries con multiple filter
CREATE INDEX CONCURRENTLY idx_users_email_status ON users(email, status);
```

## prohibited

```
❌ SELECT * en produccion
❌ Queries sin indice en columnas filtradas
❌ Listados sin paginacion
❌ N+1 queries (1 + N queries)
❌ LIKE '%value%' en columnas indexed
❌ Transactions largas que bloqeen tablas
❌ Foreign keys sin indices
```

---

✅ aplica: query_optimization + index_discipline + no_n_plus_one