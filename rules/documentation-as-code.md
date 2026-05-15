# documentation-as-code

// 📦 depende de: [[zero-errors]], [[documentation-sync]]
// 📤 exporta a: [[rules-readme]]

## filosofia

**el codigo sin documentacion es tecnica deuda desde el minuto cero. documentar mientras se codifica.**

## docstrings obligatorios

### function exported

```ts
/**
 * Crea un usuario nuevo en el sistema.
 * 
 * @param input - Datos del usuario a crear
 * @param input.email - Email unico del usuario
 * @param input.name - Nombre completo
 * @param input.role - Rol del usuario (default: 'user')
 * @returns El usuario creado con ID generado
 * @throws {EmailTakenError} Si el email ya existe
 * 
 * @example
 * const user = await createUser({
 *   email: 'test@example.com',
 *   name: 'Test User'
 * });
 */
async function createUser(input: CreateUserInput): Promise<User> { ... }
```

### class/module

```ts
/**
 * Servicio de autenticacion.
 * Maneja login, logout, refresh tokens y password reset.
 * 
 * @module auth-service
 * @requires user-repository
 * @requires email-service
 */
```

## README minimo por modulo

```
## [module-name]

Breve descripcion de responsabilidad.

### Uso

\`\`\`ts
import { ... } from './[module-name]';
\`\`\`

### API

| Funcion | Descripcion |
|---------|-------------|
| functionA | que hace |
| functionB | que hace |

### Configuracion

\`env: VAR_NAME\` - descripcion
```

## changelog estructurado

```md
## [Unreleased]

### Added
- nueva feature X

### Changed
- comportamiento de Y cambiado

### Deprecated
- `oldFunction` -> usar `newFunction`

### Fixed
- bug en Z resuelto

### Security
- vulnerabilidad en W parcheada
```

## checklist

```
□ toda funcion exportada tiene JSDoc con @param, @returns, @throws?
□ todo modulo tiene descripcion de responsabilidad?
□ los ejemplos de uso estan actualizados?
□ README existe para cada modulo significativo?
□ CHANGELOG actualizado antes de cada release?
□ no hay TODOs sin fecha ni owner?
```

---

✅ aplica: docs_como_codigo + documentacion_obligatoria + mantenibilidad