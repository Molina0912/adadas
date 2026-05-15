# anti-side-effects

// 📦 depende de: [[zero-errors]], [[secrets-and-env]]
// 📤 exporta a: [[rules-readme]]

## regla

**ningún side effect en imports. ningun estado global mutableimplicitito.**

## prohibiciones absolutas

### en imports (top-level)
- conexiones a base de datos
- apertura de archivos
- inicializacion de clientes (redis, s3, etc)
- listeners de eventos
- console.log en modulo
- escritura a process.env

```ts
// ❌ INCORRECTO - side effect en import
import { db } from './db';
db.connect(); // esto se ejecuta al cargar el modulo

// ❌ INCORRECTO - init automatico
const client = new RedisClient(config);
client.connect(); // side effect al importar

// ❌ INCORRECTO - listeners automaticos
import { events } from './events';
events.on('user:created', handler); // se ejecuta al cargar

// ❌ INCORRECTO - console en modulo
console.log('module loaded');
```

```ts
// ✅ CORRECTO - lazy initialization
export function getDb() {
  if (!db) db = new Database(config);
  return db;
}

// ✅ CORRECTO - factory function
export function createRedisClient(config: Config) {
  return new RedisClient(config);
}
```

### en el modulo (global state prohibido)

```ts
// ❌ INCORRECTO - global mutable
let cache = new Map();

// ❌ INCORRECTO - singleton implicito
class Singleton {
  static instance = new Singleton();
}

// ❌ INCORRECTO - module-level mutable
const state = { users: [] };
```

## checklist

```
□ ningun lado-effect en imports (db.connect, client.init)?
□ ningun console.log, console.error en archivos de modulo?
□ ningun proceso automatico al cargar el modulo?
□ ningun estado global mutable (let cache, globalThis)?
□ singletons solo si explicitamente documentado y necesario?
□ estado mutable solo dentro de closures o instancias?
```

## pattern: estado seguro

```ts
// ✅ estado encapsulado en factory
function createService(config: Config) {
  let cache: Map<string, any> = new Map(); // estado privado

  return {
    async get(key: string) {
      if (!cache.has(key)) {
        cache.set(key, await fetch(key));
      }
      return cache.get(key);
    },
    clear() { cache.clear(); } // para tests
  };
}
```

## senales de violation

- `new SomeClient()` en scope de modulo (sin factory)
- `connect()`, `init()`, `listen()` en nivel superior
- `console.log` antes de function exports
- `globalThis.cache = ` o similar
- `process.on` fuera de funcion

---

✅ aplica: pureza_modular + predictibilidad + testabilidad