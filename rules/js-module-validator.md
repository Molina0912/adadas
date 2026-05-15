# js-module-validator

// 📦 depende de: [[zero-errors]], [[mcp-documentation]]
// 📤 exporta a: [[rules-readme]]

## problema

error comun en modulos javascript es6:

```
Uncaught SyntaxError: The requested module '/src/file.js' does not provide an export named 'NAME'
```

esto ocurre cuando:
1. `const VALUE = ...` declarado pero importado como `export const VALUE`
2. `export default` usado pero importado como `import { VALUE }`
3. palabra clave `export` faltante en la declaracion

## regla: verificacion obligatoria de exports

para **cada archivo javascript** que crees o modifiques:

### paso 1: identificar todos los exports

busca lineas con la palabra clave `export`:

```javascript
export const x = 1;        // named export
export function fn() {}   // named export
export default class c {} // default export
```

### paso 2: verificar cada import

| tipo de export | import correcto |
|----------------|-----------------|
| `export const x = 1` | `import { x } from` |
| `export function fn()` | `import { fn } from` |
| `export default class c` | `import c from` (sin llaves) |

### paso 3: checklist

```
□ todos los exports tienen palabra clave 'export'?
□ imports usan { } para named exports?
□ imports no usan { } para export default?
□ nombres de import coinciden con exports (case-sensitive)?
□ game-state.js exporta config y game_states?
□ archivos que usan config/game_states los importan correctamente?
```

## patrones de error comunes

| patron peligroso | seal de error |
|-----------------|---------------|
| `const config = ` sin export | no se puede importar |
| `const game_states = ` sin export | no se puede importar |
| `import { x }` donde x no existe como `export const x` | import incorrecto |
| `import x from` (sin llaves) pero no hay `export default x` | import incorrecto |

## comando de verificacion automatica

```bash
# encontrar archivos que importan config/game_states
grep -r "import.*config" --include="*.js"
grep -r "import.*game_states" --include="*.js"
```

## proyecto void-collector (aplicado)

error encontrado:

```
X [ERROR] No matching export in "src/game-state.js" for import "config"
```

**causa raiz**: `game-state.js` tinha `const config = {...}` sin `export`

**solucion aplicada**:

```javascript
// ANTES (INCORRECTO):
const config = { bounds: 50, ... };

// DESPUES (CORRECTO):
export const config = { bounds: 50, ... };
```

**estado**: ✅ corregido - todos los exports ahora usan palabra clave `export`

---

✅ reglas aplicadas: minúsculas + modularidad + trazabilidad_[[wiki]] + imports_sincronizados