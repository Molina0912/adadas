---
name: typescript-advanced-types
description: Master TypeScript's advanced type system including generics, conditional types, mapped types, template literals, and utility types for building type-safe applications. Use when implementing complex type logic, creating reusable type utilities, or ensuring compile-time type safety in TypeScript projects.
---

# TypeScript Advanced Types

Comprehensive guidance for mastering TypeScript's advanced type system including generics, conditional types, mapped types, template literal types, and utility types for building robust, type-safe applications.

## When to Use This Skill

- Building type-safe libraries or frameworks
- Creating reusable generic components
- Implementing complex type inference logic
- Designing type-safe API clients
- Building form validation systems
- Migrating JavaScript codebases to TypeScript

## Core Concepts

### 1. Generics

**Basic Generic Function:**

```typescript
function identity<T>(value: T): T {
  return value;
}

const num = identity<number>(42); // Type: number
const str = identity<string>("hello"); // Type: string
```

**Generic Constraints:**

```typescript
interface HasLength {
  length: number;
}

function logLength<T extends HasLength>(item: T): T {
  console.log(item.length);
  return item;
}

logLength("hello"); // OK
logLength([1, 2, 3]); // OK
logLength({ length: 10 }); // OK
```

### 2. Conditional Types

```typescript
type IsString<T> = T extends string ? true : false;

type A = IsString<string>; // true
type B = IsString<number>; // false
```

**Infer keyword:**

```typescript
type ReturnType<T> = T extends (...args: any[]) => infer R ? R : never;

function getUser() { return { id: 1, name: "John" }; }
type User = ReturnType<typeof getUser>; // { id: number; name: string }
```

### 3. Mapped Types

```typescript
type Readonly<T> = {
  readonly [P in keyof T]: T[P];
};

type Partial<T> = {
  [P in keyof T]?: T[P];
};

type Pick<T, K extends keyof T> = {
  [P in K]: T[P];
};

type Omit<T, K extends keyof T> = {
  [P in keyof T as P extends K ? never : P]: T[P];
};
```

### 4. Template Literal Types

```typescript
type EventName = "click" | "focus" | "blur";
type EventHandler = `on${Capitalize<EventName>}`;
// Type: "onClick" | "onFocus" | "onBlur"
```

### 5. Utility Types

```typescript
// Built-in
Partial<T>       // Make all properties optional
Required<T>      // Make all properties required
Readonly<T>      // Make all properties readonly
Pick<T, K>       // Select specific properties
Omit<T, K>       // Remove specific properties
Exclude<T, U>    // Exclude types from union
Extract<T, U>    // Extract types from union
NonNullable<T>   // Exclude null and undefined
Record<K, T>     // Create object type with keys K and values T
```

## Advanced Patterns

### Type-Safe Event Emitter

```typescript
type EventMap = {
  "user:created": { id: string; name: string };
  "user:updated": { id: string };
};

class TypedEventEmitter<T extends Record<string, any>> {
  private listeners: { [K in keyof T]?: Array<(data: T[K]) => void> } = {};

  on<K extends keyof T>(event: K, callback: (data: T[K]) => void): void {
    if (!this.listeners[event]) this.listeners[event] = [];
    this.listeners[event]!.push(callback);
  }

  emit<K extends keyof T>(event: K, data: T[K]): void {
    this.listeners[event]?.forEach(cb => cb(data));
  }
}
```

### Deep Readonly/Partial

```typescript
type DeepReadonly<T> = {
  readonly [P in keyof T]: T[P] extends object
    ? T[P] extends Function ? T[P] : DeepReadonly<T[P]>
    : T[P];
};

type DeepPartial<T> = {
  [P in keyof T]?: T[P] extends object
    ? T[P] extends Array<infer U> ? Array<DeepPartial<U>> : DeepPartial<T[P]>
    : T[P];
};
```

## Best Practices

1. **Use `unknown` over `any`**: Enforce type checking
2. **Prefer `interface` for object shapes**: Better error messages
3. **Use `type` for unions and complex types**: More flexible
4. **Leverage type inference**: Let TypeScript infer when possible
5. **Use const assertions**: Preserve literal types
6. **Use strict mode**: Enable all strict compiler options