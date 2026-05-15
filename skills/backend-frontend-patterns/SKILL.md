---
name: backend-frontend-patterns
description: Use when creating backends, REST/GraphQL/tRPC/gRPC APIs, WebSocket servers, FastAPI/Python/TypeScript backends, or frontend-backend integration. Provides code patterns and best practices for API development (2025-2027).
---

# Backend-Frontend Patterns Skill (2025-2027)

## Cuando Usar Este Skill

Usa este skill cuando:
- Usuario pide crear un **backend**, **API**, o **servidor**
- Necesitas implementar **REST**, **GraphQL**, **tRPC**, **gRPC**, o **WebSockets**
- Desarrollar **FastAPI** (Python), **Express** (TypeScript), o **Apollo Server**
- Crear **autenticación JWT**, **OAuth 2.1**, o **sistemas de tokens**
- Necesitas ejemplos de **conexión frontend-backend**
- Projetype: aplicación full-stack, microservicios, o API pública

---

## Tecnologías y Patrones (2025-2027)

### 1. REST + OpenAPI (Estándar de facto)
```
Stack: TypeScript + Express + Zod + jsonwebtoken + OpenAPI 3.1
Caso: APIs públicas, microservicios simples
Ventaja: Universal, caching HTTP nativo
```

### 2. GraphQL + Apollo (Flexibilidad máxima)
```
Stack: Apollo Server 4 + Prisma + graphql-tag
Caso: Múltiples clientes (web, móvil) con distintos perfiles de consumo
Ventaja: Elimina over-fetching y under-fetching
```

### 3. tRPC (Tipificación end-to-end - 89% menos errores API)
```
Stack: @trpc/server + Zod + Express/Next.js
Caso: Full-stack TypeScript, equipos pequeños, T3 Stack
Ventaja: Tipos inferidos automáticamente, sin OpenAPI externo
```

### 4. gRPC (Alto rendimiento)
```
Stack: Protocol Buffers + grpc + Go/Python
Caso: Microservicios de alto rendimiento, fintech, IoT
Ventaja: 10-30% más eficiente que JSON, streaming bidireccional
```

### 5. WebSockets (Tiempo real)
```
Stack: FastAPI (Python) + ws / Socket.io (JS)
Caso: Chat, notificaciones, dashboards financieros, gaming
Ventaja: Conexión bidireccional persistente, sub-2ms latencia
```

---

## Estructura de Backend Recomendada

```
backend/
├── src/
│   ├── routes/           # Endpoints organizados por dominio
│   │   └── tasks.routes.ts
│   ├── middleware/        # Auth, validación, errores
│   │   └── auth.ts
│   ├── schemas/          # Zod/Pydantic para validación
│   │   └── task.schema.ts
│   ├── services/         # Lógica de negocio
│   │   └── task.service.ts
│   ├── models/           # Modelos de datos (Prisma/TypeORM)
│   └── server.ts         # Entry point
├── prisma/               # Schema de base de datos
├── openapi.yaml          # Documentación API
└── package.json
```

---

## Validación de Datos (Obligatorio)

### TypeScript + Zod
```typescript
import { z } from 'zod';

const CreateTaskSchema = z.object({
  title: z.string().min(3).max(100),
  description: z.string().optional(),
  priority: z.enum(['LOW', 'MEDIUM', 'HIGH']).default('MEDIUM')
});

// Usage
const validated = CreateTaskSchema.parse(req.body);
```

### Python + Pydantic
```python
from pydantic import BaseModel, EmailStr, Field

class TaskCreate(BaseModel):
    title: str = Field(..., min_length=3, max_length=100)
    description: str | None = None
    priority: Literal['LOW', 'MEDIUM', 'HIGH'] = 'MEDIUM'
```

---

## Autenticación (2026 Best Practices)

### JWT con expiración corta
```typescript
// Access token: 15 min
// Refresh token: 7 días (rotativo)
const accessToken = jwt.sign(
  { userId, email, role },
  process.env.JWT_SECRET!,
  { expiresIn: '15m' }
);
```

### OAuth 2.1 + PKCE (SPAs)
- Authorization Code + PKCE para SPAs
- Refresh token rotation
- Token stored in httpOnly cookie (no localStorage)

### Middleware de autenticación
```typescript
export async function authenticate(req: Request, res: Response, next: NextFunction) {
  const token = req.headers.authorization?.split(' ')[1];
  if (!token) return res.status(401).json({ error: 'Token requerido' });
  
  try {
    const payload = jwt.verify(token, process.env.JWT_SECRET!) as jwt.JwtPayload;
    (req as any).user = payload;
    next();
  } catch {
    return res.status(401).json({ error: 'Token inválido' });
  }
}
```

---

## Seguridad API (NIST SP 800-228 + OWASP Top 10)

### Canonicalización de credenciales
- API keys, JWT, OAuth, SPIFFE → forma interna estandarizada
- Implementar en API Gateway

### Rate Limiting
```typescript
// 100 req/min por IP
// 1000 req/min por usuario autenticado
// Usar Redis para tracking
```

### Headers de seguridad
```typescript
// Helmet.js
app.use(helmet());
app.disable('x-powered-by');
```

### Validación estricta de inputs
- Nunca confiar en tipos del cliente
- Sanitizar outputs
- Usar prepared statements para SQL

---

## Stacks Full-Stack Recomendados (2025-2027)

| Stack | Frontend | Backend | DB | Estado |
|-------|----------|---------|-----|--------|
| **T3 Stack** | Next.js | tRPC | Prisma | ⭐ Recomendado |
| **React + Node** | Next.js 15 | Zustand + TanStack | Prisma/Drizzle | Popular |
| **Angular + Nest** | Angular v19+ | NestJS | TypeORM/Prisma | Enterprise |
| **FastAPI + Go** | Vue/Nuxt | FastAPI (Python) | PostgreSQL | Rendimiento |

---

## Checklist de Seguridad para APIs

- [ ] OAuth 2.1 con PKCE para SPAs
- [ ] JWT con expiración corta (15 min access, 7 días refresh)
- [ ] Rate limiting por IP y usuario
- [ ] Validación Zod/Pydantic en entrada y salida
- [ ] CORS configurado (no `*` en producción)
- [ ] Helmet.js para headers de seguridad
- [ ] No hardcoded secrets → variables de entorno
- [ ] Logs sin datos sensibles
- [ ] Canonicalización de credenciales en gateway

---

## Comando Relacionado

Usa `/backend-frontend-examples` para ver código completo y funcional de todos los patrones.

---

**Referencias:**
- [[3]](https://dev.to/dataformathub/api-design-2026-why-the-multi-protocol-approach-is-the-ultimate-guide-2h6o) REST + OpenAPI
- [[22]](https://dev.to/pockit_tools/rest-vs-graphql-vs-trpc-vs-grpc-in-2026-the-definitive-guide-to-choosing-your-api-layer-1j8m) API Layer Comparison
- [[31]](https://www.askantech.com/trpc-end-to-end-type-safety-typescript-first-apis/) tRPC 89% reducción errores
- [[9]](https://www.linkedin.com/pulse/operationalizing-nist-800-228-roadmap-secure-api-john-waller-4rc2c) NIST SP 800-228 Zero Trust