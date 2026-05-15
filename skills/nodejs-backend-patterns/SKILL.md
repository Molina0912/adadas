---
name: nodejs-backend-patterns
description: Build production-ready Node.js backend services with Express/Fastify, implementing middleware patterns, error handling, authentication, database integration, and API design best practices. Use when creating Node.js servers, REST APIs, GraphQL backends, or microservices architectures.
---

# Node.js Backend Patterns

Comprehensive guidance for building scalable, maintainable, and production-ready Node.js backend applications with modern frameworks, architectural patterns, and best practices.

## When to Use This Skill

- Building REST APIs or GraphQL servers
- Creating microservices with Node.js
- Implementing authentication and authorization
- Designing scalable backend architectures
- Setting up middleware and error handling
- Integrating databases (SQL and NoSQL)
- Building real-time applications with WebSockets

## Core Frameworks

### Express.js - Minimalist Framework

```typescript
import express from "express";
import helmet from "helmet";
import cors from "cors";
import compression from "compression";

const app = express();

app.use(helmet());
app.use(cors({ origin: process.env.ALLOWED_ORIGINS?.split(",") }));
app.use(compression());
app.use(express.json({ limit: "10mb" }));

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Server on port ${PORT}`));
```

### Fastify - High Performance

```typescript
import Fastify from "fastify";

const fastify = Fastify({ logger: true });

await fastify.register(helmet);
await fastify.register(cors, { origin: true });

fastify.post<{ Body: { name: string } }>(
  "/users",
  { schema: { body: { type: "object", required: ["name"], properties: { name: { type: "string" } } } } },
  async (request, reply) => ({ id: "123", name: request.body.name })
);

await fastify.listen({ port: 3000, host: "0.0.0.0" });
```

## Layered Architecture

```
src/
├── controllers/     # HTTP requests/responses
├── services/        # Business logic
├── repositories/     # Data access
├── middleware/       # Express/Fastify middleware
├── routes/          # Route definitions
└── types/           # TypeScript types
```

## Middleware Patterns

### Authentication

```typescript
export const authenticate = async (req, res, next) => {
  try {
    const token = req.headers.authorization?.replace("Bearer ", "");
    if (!token) throw new UnauthorizedError("No token provided");
    req.user = jwt.verify(token, process.env.JWT_SECRET!);
    next();
  } catch {
    next(new UnauthorizedError("Invalid token"));
  }
};
```

### Rate Limiting

```typescript
import rateLimit from "express-rate-limit";

export const apiLimiter = rateLimit({
  windowMs: 15 * 60 * 1000,
  max: 100,
  message: "Too many requests, try again later"
});
```

## Error Handling

```typescript
export class AppError extends Error {
  constructor(
    public message: string,
    public statusCode: number = 500,
    public isOperational: boolean = true
  ) {
    super(message);
    Object.setPrototypeOf(this, AppError.prototype);
  }
}

export class ValidationError extends AppError {
  constructor(message: string, public errors?: any[]) {
    super(message, 400);
  }
}

export const errorHandler = (err, req, res, next) => {
  if (err instanceof AppError) {
    return res.status(err.statusCode).json({
      status: "error",
      message: err.message,
      ...(err instanceof ValidationError && { errors: err.errors })
    });
  }
  res.status(500).json({ status: "error", message: "Internal server error" });
};
```

## Best Practices

1. **Use TypeScript**: Type safety prevents runtime errors
2. **Validate input**: Use Zod or Joi
3. **Use environment variables**: Never hardcode secrets
4. **Implement logging**: Use Pino or Winston
5. **Add rate limiting**: Prevent abuse
6. **Use connection pooling**: For databases
7. **Handle graceful shutdown**: Clean up resources
8. **Write tests**: Unit, integration, and E2E