# domain-driven-boundaries

// 📦 depende de: [[zero-errors]]
// 📤 exporta a: [[rules-readme]]

## regla

**ningún módulo puede importar desde dominios hermanos directamente.**

## estructura de capas (autorizada)

```
presentacion → aplicacion → dominio ← infraestructura
```

Lo siguiente está **prohibido**:
- `billing` importando directamente de `auth`
- `analytics` importando directamente de `billing`
- `ui` importando infraestructura directamente
- `domain` dependiendo de código de framework

## permitted imports

| desde | hacia | permitido |
|-------|-------|-----------|
| presentacion | aplicacion | ✅ |
| aplicacion | dominio | ✅ |
| dominio | infraestructura | ✅ |
| infraestructura | dominio | ✅ (solo contracts) |
| dominio | dominio | ✅ (mismo modulo) |
| aplicacion | presentacion | ❌ |
| dominio | aplicacion | ❌ |
| infraestructura | presentacion | ❌ |

## checklist obligatorio

```
□ ningun import cruzado arbitrario entre dominios hermanos?
□ todo acceso cross-dominio va por adapter?
□ los contracts (interfaces) estan en dominio, no en infra?
□ no hay circulos: a->b->c->a?
```

## adapters obligatorios

Si un dominio necesita otro:
1. definir interfaz en dominio propio
2. implementar adapter en infraestructura
3. inyectar por dependencia

```ts
// billing/domain/ports.ts
export interface UserReader {
  getUser(id: string): Promise<User>;
}

// billing/infra/adapters/user-http-adapter.ts
export class UserHttpAdapter implements UserReader { ... }
```

## senales de violation

```
billing.getUser()        // viola: billing -> auth directo
analytics.getUser()      // viola: analytics -> auth directo
直接从 infra 调用另一个 domain 的 repo      // viola
```

---

✅ aplica: arquitectura_modular + bajo_acoplamiento + escalabilidad