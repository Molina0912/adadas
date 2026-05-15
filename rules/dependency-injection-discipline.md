# dependency-injection-discipline

// 📦 depende de: [[zero-errors]], [[module-isolation]], [[anti-side-effects]]
// 📤 exporta a: [[rules-readme]]

## regla

**nunca instanciar dependencias directamente dentro de funciones de negocio.**

## prohibido

```ts
// ❌ INCORRECTO - instanciacion directa en logica de negocio
function processOrder(order: Order) {
  const db = new Database(); // viola: dependencia directa
  const logger = new Logger(); // viola: dependencia directa
  // ...
}

// ❌ INCORRECTO - import y uso directo con SQL injection
import { db } from './db';
function getUser(id: string) {
  return db.query(`SELECT * FROM users WHERE id = '${id}'`);
}

// ❌ INCORRECTO - singleton implicito
class UserService {
  private static instance = new UserService(); // viola: acoplamiento
}
```

## correcto: inyeccion por constructor

```ts
// ✅ CORRECTO - inyeccion por constructor
class OrderService {
  constructor(
    private readonly db: Database,
    private readonly logger: Logger,
    private readonly mailer: Mailer
  ) {}
  async processOrder(order: Order) {
    this.logger.info('processing order', { orderId: order.id });
    const saved = await this.db.orders.create(order);
    await this.mailer.sendConfirmation(order.userId);
    return saved;
  }
}

// uso
const orderService = new OrderService(
  new Database(config),
  new Logger(config),
  new Mailer(config)
);
```

## correcto: inyeccion por parametros

```ts
// ✅ CORRECTO - factory function
function createOrderService(deps: Deps) {
  return {
    processOrder: async (order: Order) => {
      const saved = await deps.db.orders.create(order);
      return saved;
    }
  };
}

// uso
const deps = { db: new Database(config), logger: new Logger(config) };
const orderService = createOrderService(deps);
```

## para tests: mocks sin modificar produccion

```ts
// ✅ CORRECTO - se puede inyectar mock en tests
const mockDb = { orders: { create: jest.fn().mockResolvedValue({ id: '1' }) } };
const service = new OrderService(mockDb, mockLogger, mockMailer);
```

## checklist

```
□ ninguna dependencia instanciada dentro de funciones de negocio?
□ todas las dependencias inyectadas por constructor o parametros?
□ se usan interfaces para desacoplar modulos?
□ los tests pueden usar mocks sin modificar codigo de produccion?
□ ningun import directo a modulos de infraestructura en dominio?
```

---

✅ aplica: bajo_acoplamiento + testabilidad + intercambiabilidad