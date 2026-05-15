# module-isolation

// 📦 depende de: [[domain-driven-boundaries]], [[zero-errors]]
// 📤 exporta a: [[rules-readme]]

## filosofia

**cada modulo es independiente. puede vivir solo. puede moverse sin romper otros.**

## estructura de modulo valido

```
modulo/
├── domain/
│   ├── types.ts           # tipos propios del dominio
│   ├── services.ts        # logica de negocio
│   └── ports.ts           # interfaces para infra
├── infrastructure/
│   ├── adapters/         # implementaciones de ports
│   └── repositories/     # acceso a datos
├── presentation/
│   ├── routes.ts         # endpoints si aplica
│   └── controllers.ts    # presentacion
└── __tests__/
    ├── unit/
    └── integration/
```

## regla de isolation

```
cada modulo define:
1. sus propios tipos (domain/types.ts)
2. su propia logica (domain/services.ts)
3. sus propias interfaces (domain/ports.ts)
4. sus propias pruebas (__tests__/)
```

## public API (unico punto de contacto)

```ts
// modulo/src/index.ts - unico export publico
export { UserService } from './domain/services';
export type { UserReader, UserUpdater } from './domain/ports';

// ❌ NO exportar nada interno
export { InternalCache } from './infrastructure/cache'; // VIOLA isolation
```

## imports cross-modulo

```ts
// ✅ CORRECTO - a traves de public API
import { UserService } from '../users';

// ❌ INCORRECTO - import interno directo
import { UserCache } from '../users/infrastructure/cache'; // VIOLA isolation
```

## checklist

```
□ el modulo tiene src/index.ts con solo exports publicos?
□ no hay exports de archivos internos (infrastructure, __tests__)?
□ cada modulo tiene sus propios tipos, servicios, ports?
□ los imports entre modulos van por public API?
□ el modulo puede moverse a otro proyecto sin cambios?
```

---

✅ aplica: aislamiento + autonomia + movible_sin_romper