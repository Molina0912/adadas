---
description: Practical code examples for backend-frontend communication (2025-2027): REST+TypeScript+Express, GraphQL+Apollo, tRPC, WebSockets+FastAPI, JWT+OAuth2.1 authentication patterns
agent: build
---

# Ejemplos Prácticos de Conexión Backend-Frontend (2025-2027)

## 1. REST API con TypeScript + Express (Backend) + Fetch (Frontend)

### Backend: Endpoint REST con validación Zod y JWT

```typescript
// src/routes/tasks.routes.ts
import { Router, Request, Response } from 'express';
import { z } from 'zod';
import jwt from 'jsonwebtoken';

const router = Router();

const CreateTaskSchema = z.object({
  title: z.string().min(3).max(100),
  description: z.string().optional(),
  priority: z.enum(['LOW', 'MEDIUM', 'HIGH']).default('MEDIUM')
});

const authenticate = (req: Request, res: Response, next: Function) => {
  const token = req.headers.authorization?.split(' ')[1];
  if (!token) return res.status(401).json({ error: 'Token requerido' });
  
  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET!);
    (req as any).userId = (decoded as any).userId;
    next();
  } catch {
    return res.status(401).json({ error: 'Token inválido' });
  }
};

router.post('/tasks', authenticate, async (req: Request, res: Response) => {
  try {
    const validated = CreateTaskSchema.parse(req.body);
    const newTask = {
      id: crypto.randomUUID(),
      ...validated,
      userId: (req as any).userId,
      createdAt: new Date().toISOString()
    };
    res.status(201).json({ success: true, data: newTask });
  } catch (error) {
    if (error instanceof z.ZodError) {
      return res.status(400).json({ error: 'Validación fallida', details: error.errors });
    }
    res.status(500).json({ error: 'Error interno del servidor' });
  }
});

router.get('/tasks', authenticate, async (req: Request, res: Response) => {
  const tasks = [
    { id: '1', title: 'Tarea ejemplo', priority: 'HIGH', createdAt: new Date().toISOString() }
  ];
  res.json({ success: true, data: tasks });
});

export default router;
```

### Frontend: Cliente con Fetch API + TypeScript

```typescript
// src/services/api.ts
const API_BASE = 'http://localhost:3000/api';

interface Task {
  id: string;
  title: string;
  description?: string;
  priority: 'LOW' | 'MEDIUM' | 'HIGH';
  createdAt: string;
}

interface CreateTaskInput {
  title: string;
  description?: string;
  priority?: 'LOW' | 'MEDIUM' | 'HIGH';
}

export class ApiService {
  private token: string | null = null;

  setToken(token: string) { this.token = token; }

  private async request<T>(endpoint: string, options: RequestInit = {}): Promise<T> {
    const response = await fetch(`${API_BASE}${endpoint}`, {
      ...options,
      headers: {
        'Content-Type': 'application/json',
        ...(this.token && { Authorization: `Bearer ${this.token}` }),
        ...options.headers,
      },
    });

    if (!response.ok) {
      const error = await response.json();
      throw new Error(error.error || 'Error en la petición');
    }

    return response.json();
  }

  async createTask(input: CreateTaskInput): Promise<Task> {
    const response = await this.request<{ success: boolean; data: Task }>('/tasks', {
      method: 'POST',
      body: JSON.stringify(input),
    });
    return response.data;
  }

  async getTasks(): Promise<Task[]> {
    const response = await this.request<{ success: boolean; data: Task[] }>('/tasks');
    return response.data;
  }
}
```

---

## 2. GraphQL con Apollo Server + React

### Backend: Schema y Resolvers con Apollo Server 4

```typescript
// src/schema/typeDefs.ts
import { gql } from 'graphql-tag';

export const typeDefs = gql`
  type User { id: ID!, email: String!, name: String!, tasks: [Task!]! }
  type Task {
    id: ID!, title: String!, description: String, priority: Priority!
    status: TaskStatus!, createdAt: String!, assignee: User
  }
  enum Priority { LOW MEDIUM HIGH }
  enum TaskStatus { TODO IN_PROGRESS DONE }

  type Query {
    tasks(filter: TaskFilter): [Task!]!
    task(id: ID!): Task
    me: User
  }

  type Mutation {
    createTask(input: CreateTaskInput!): Task!
    updateTask(id: ID!, input: UpdateTaskInput!): Task!
  }

  input TaskFilter { status: TaskStatus, priority: Priority }
  input CreateTaskInput { title: String!, description: String, priority: Priority }
  input UpdateTaskInput { title: String, description: String, priority: Priority, status: TaskStatus }
`;

export const resolvers = {
  Query: {
    tasks: async (_: any, { filter }: any, context: any) => {
      return context.prisma.task.findMany({
        where: filter ? { status: filter.status, priority: filter.priority } : undefined,
        include: { assignee: true }
      });
    },
    me: async (_: any, __: any, context: any) => context.currentUser
  },
  Mutation: {
    createTask: async (_: any, { input }: any, context: any) => {
      if (!context.currentUser) throw new Error('Autenticación requerida');
      return context.prisma.task.create({
        data: { ...input, creatorId: context.currentUser.id, status: 'TODO' },
        include: { assignee: true }
      });
    }
  }
};
```

### Frontend: Apollo Client en React

```typescript
// src/components/TaskList.tsx
import { useQuery, useMutation, gql } from '@apollo/client';

export const GET_TASKS = gql`
  query GetTasks($filter: TaskFilter) {
    tasks(filter: $filter) {
      id title description priority status
      assignee { name }
    }
  }
`;

export function TaskList() {
  const { data, loading, error } = useQuery(GET_TASKS, {
    variables: { filter: { status: 'TODO' } }
  });

  const [createTask] = useMutation(CREATE_TASK, { refetchQueries: [{ query: GET_TASKS }] });

  if (loading) return <div>Cargando...</div>;
  if (error) return <div>Error: {error.message}</div>;

  return (
    <div>
      {data.tasks.map(task => (
        <div key={task.id}>
          <h3>{task.title}</h3>
          <span>{task.priority} - {task.status}</span>
        </div>
      ))}
    </div>
  );
}
```

---

## 3. tRPC: Tipificación End-to-End sin Esquemas

### Backend: Router tRPC con Express

```typescript
// src/server/trpc.ts
import { initTRPC } from '@trpc/server';
import { z } from 'zod';

const t = initTRPC.create();

export const appRouter = t.router({
  getUser: t.procedure
    .input(z.object({ id: z.string() }))
    .query(async ({ input, ctx }) => {
      return ctx.prisma.user.findUnique({ where: { id: input.id } });
    }),

  createTask: t.procedure
    .input(z.object({
      title: z.string().min(3),
      priority: z.enum(['LOW', 'MEDIUM', 'HIGH']).optional(),
      projectId: z.string()
    }))
    .mutation(async ({ input, ctx }) => {
      if (!ctx.user) throw new Error('No autenticado');
      return ctx.prisma.task.create({
        data: {
          title: input.title,
          priority: input.priority ?? 'MEDIUM',
          projectId: input.projectId,
          creatorId: ctx.user.id
        }
      });
    }),

  taskUpdated: t.procedure
    .input(z.object({ projectId: z.string() }))
    .subscription(async function* ({ input, ctx }) {
      for await (const task of ctx.pubsub.subscribe(`task:${input.projectId}`)) {
        yield task;
      }
    })
});

export type AppRouter = typeof appRouter;
```

### Frontend: Cliente tRPC con inferencia automática

```typescript
// src/client/trpc.ts
import { createTRPCProxyClient, httpBatchLink } from '@trpc/client';
import type { AppRouter } from '../../server/trpc';

export const trpc = createTRPCProxyClient<AppRouter>({
  links: [httpBatchLink({
    url: 'http://localhost:3000/trpc',
    headers: () => {
      const token = localStorage.getItem('token');
      return token ? { authorization: `Bearer ${token}` } : {};
    }
  })]
}
```

```typescript
// src/components/TaskManager.tsx
import { trpc } from '../client/trpc';

export function TaskManager({ projectId }: { projectId: string }) {
  const { data: tasks } = trpc.getUser.useQuery({ id: 'user123' });
  
  const createTask = trpc.createTask.useMutation({
    onSuccess: () => { trpc.getUser.invalidate(); }
  });

  const handleSubmit = async (title: string) => {
    await createTask.mutateAsync({
      title,
      priority: 'HIGH',
      projectId
      // TypeScript marca error si el tipo no coincide
    });
  };

  return <div>{tasks?.tasks.map(task => <div key={task.id}>{task.title}</div>)}</div>;
}
```

**Ventaja**: Si cambias el schema en backend, TypeScript marca errores en frontend **antes de ejecutar** [[31]].

---

## 4. WebSockets con FastAPI + JavaScript

### Backend: FastAPI WebSocket

```python
# main.py
from fastapi import FastAPI, WebSocket, WebSocketDisconnect
from pydantic import BaseModel
from datetime import datetime
import json

app = FastAPI()

class ConnectionManager:
    def __init__(self):
        self.active_connections: dict[str, WebSocket] = {}
    
    async def connect(self, user_id: str, websocket: WebSocket):
        await websocket.accept()
        self.active_connections[user_id] = websocket
    
    def disconnect(self, user_id: str):
        self.active_connections.pop(user_id, None)
    
    async def send_personal(self, message: dict, user_id: str):
        if user_id in self.active_connections:
            await self.active_connections[user_id].send_text(json.dumps(message))

manager = ConnectionManager()

class Notification(BaseModel):
    type: str
    message: str
    timestamp: str = datetime.now().isoformat()
    data: dict | None = None

@app.websocket("/ws/notifications/{user_id}")
async def websocket_endpoint(websocket: WebSocket, user_id: str):
    await manager.connect(user_id, websocket)
    try:
        while True:
            await websocket.receive_text()
    except WebSocketDisconnect:
        manager.disconnect(user_id)

async def notify_user(user_id: str, notification: Notification):
    await manager.send_personal(notification.dict(), user_id)
```

### Frontend: Cliente WebSocket con reconexión

```typescript
// src/services/websocket.ts
export class RealtimeService {
  private ws: WebSocket | null = null;
  private reconnectAttempts = 0;
  private readonly maxReconnectAttempts = 5;

  connect(onMessage: (data: any) => void, onError?: (error: Event) => void) {
    this.ws = new WebSocket(`${this.baseUrl}/ws/notifications/${this.userId}`);

    this.ws.onmessage = (event) => {
      const data = JSON.parse(event.data);
      onMessage(data);
      this.reconnectAttempts = 0;
    };

    this.ws.onclose = () => {
      if (this.reconnectAttempts < this.maxReconnectAttempts) {
        const delay = Math.min(1000 * Math.pow(2, this.reconnectAttempts), 10000);
        setTimeout(() => {
          this.reconnectAttempts++;
          this.connect(onMessage, onError);
        }, delay);
      }
    };
  }

  disconnect() { this.ws?.close(); this.ws = null; }
  sendHeartbeat() { this.ws?.send(JSON.stringify({ type: 'PING', timestamp: Date.now() })); }
}
```

---

## 5. Autenticación: JWT + OAuth 2.1 (Mejores Prácticas 2026)

### Backend: Middleware con PKCE y refresh tokens

```typescript
// src/middleware/auth.ts
import { Request, Response, NextFunction } from 'express';
import jwt from 'jsonwebtoken';
import { z } from 'zod';

const TokenPayloadSchema = z.object({
  userId: z.string(), email: z.string().email(),
  role: z.enum(['USER', 'ADMIN']), iat: z.number(), exp: z.number()
});

export async function authenticate(req: Request, res: Response, next: NextFunction) {
  const authHeader = req.headers.authorization;
  
  if (!authHeader?.startsWith('Bearer ')) {
    return res.status(401).json({ error: { code: 'MISSING_TOKEN', message: 'Token requerido' } });
  }

  const token = authHeader.slice(7);

  try {
    const payload = jwt.verify(token, process.env.JWT_SECRET!) as jwt.JwtPayload;
    const validated = TokenPayloadSchema.parse(payload);
    const now = Math.floor(Date.now() / 1000);
    
    if (validated.exp < now - 30) {
      return res.status(401).json({ error: { code: 'TOKEN_EXPIRED', message: 'Token expirado' } });
    }

    (req as any).user = validated;
    next();
  } catch {
    return res.status(401).json({ error: { code: 'INVALID_TOKEN', message: 'Token inválido' } });
  }
}
```

### Frontend: Interceptor Axios con refresh automático

```typescript
// src/api/axios.ts
import axios from 'axios';

const api = axios.create({ baseURL: 'http://localhost:3000/api', timeout: 10000 });

api.interceptors.request.use((config) => {
  const token = localStorage.getItem('accessToken');
  if (token) config.headers.Authorization = `Bearer ${token}`;
  return config;
});

let isRefreshing = false;
let failedQueue: Array<{ resolve: Function; reject: Function }> = [];

api.interceptors.response.use(
  response => response,
  async (error) => {
    const originalRequest = error.config;
    
    if (error.response?.status === 401 && !originalRequest._retry) {
      if (isRefreshing) {
        return new Promise((resolve, reject) => {
          failedQueue.push({ resolve, reject });
        }).then(token => {
          originalRequest.headers.Authorization = `Bearer ${token}`;
          return api(originalRequest);
        });
      }

      originalRequest._retry = true;
      isRefreshing = true;

      try {
        const refreshToken = localStorage.getItem('refreshToken');
        const response = await axios.post('/api/auth/refresh', { refreshToken });
        const { accessToken } = response.data;
        localStorage.setItem('accessToken', accessToken);
        
        failedQueue.forEach(prom => prom.resolve(accessToken));
        originalRequest.headers.Authorization = `Bearer ${accessToken}`;
        return api(originalRequest);
      } catch (refreshError) {
        localStorage.clear();
        failedQueue.forEach(prom => prom.reject(refreshError));
        window.location.href = '/login';
        return Promise.reject(refreshError);
      } finally {
        isRefreshing = false;
        failedQueue = [];
      }
    }
    
    return Promise.reject(error);
  }
);

export default api;
```

---

## Comparativa Rápida

| Tecnología | Mejor para | Ventajas 2026 | Complejidad |
|-----------|-----------|--------------|-------------|
| **REST + OpenAPI** | APIs públicas, microservicios simples | Estándar universal, caching HTTP nativo | ⭐ Baja |
| **GraphQL** | Apps con múltiples clientes, datos complejos | Query flexible, evita over-fetching | ⭐⭐ Media |
| **tRPC** | Full-stack TypeScript, equipos pequeños | Tipado end-to-end, 89% menos errores [[31]] | ⭐⭐ Media |
| **gRPC** | Microservicios de alto rendimiento, fintech | Binario, 10-30% más rápido que JSON | ⭐⭐⭐ Alta |
| **WebSockets** | Chat, notificaciones, dashboards real-time | Conexión persistente, baja latencia | ⭐⭐ Media |

---

## Checklist de Seguridad para APIs en 2026 [[37]][[40]]

- [ ] **Autenticación**: OAuth 2.1 con PKCE para SPAs, JWT con expiración corta (15 min)
- [ ] **Autorización**: Validar permisos en cada resolver/endpoint
- [ ] **Rate Limiting**: Límites por IP y usuario (ej: 100 req/min) con Redis
- [ ] **Validación**: Zod/Pydantic en entrada y salida
- [ ] **CORS**: Orígenes permitidos explícitamente, no `*` en producción
- [ ] **Headers de seguridad**: Helmet.js para HSTS, X-Frame-Options
- [ ] **Secrets**: Variables de entorno con validación de esquema

---

**References:**
- [[3]](https://dev.to/dataformathub/api-design-2026-why-the-multi-protocol-approach-is-the-ultimate-guide-2h6o) REST + OpenAPI estándar de facto
- [[22]](https://dev.to/pockit_tools/rest-vs-graphql-vs-trpc-vs-grpc-in-2026-the-definitive-guide-to-choosing-your-api-layer-1j8m) tRPC vs GraphQL vs gRPC
- [[31]](https://www.askantech.com/trpc-end-to-end-type-safety-typescript-first-apis/) 89% reducción errores con tRPC
- [[37]](https://learn.microsoft.com/en-us/azure/api-management/api-management-api-import-restrictions) OpenAPI 3.1 limitaciones Azure
- [[40]] OAuth 2.1 + PKCE best practices 2026