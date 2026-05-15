---
name: js-module-validator
description: |
  USA ESTE SKILL cuando:
  - Crear o modificar archivos JavaScript con módulos ES (import/export)
  - El usuario pida "regla" o "validación" para evitar errores de imports/exports
  - Errores como "does not provide an export named 'X'"
  - Proyectos JavaScript/TypeScript con múltiples módulos

  Esta skill valida que todos los exports sean correctos y los imports coincidan.
---

# JS Module Validator - Regla de Validación de Exports/Imports

## Problema Común

En JavaScript módulos ES6, un error frecuente es:
```
Uncaught SyntaxError: The requested module '/src/archivo.js' does not provide an export named 'NOMBRE'
```

Esto ocurre cuando:
1. Se declara `const VALOR = ...` pero se importa como `export const VALOR`
2. Se usa `export default` pero se importa como `import { VALOR }`
3. Se omite `export` en la declaración de una constante o función

## REGLA DE ORO: Verificación Obligatoria de Exports

### Para cada archivo JavaScript que crees o modifiques:

1. **Identificar todos los exports del archivo**
   - Buscar líneas con `export` (no solo `export function`, también `export const`, `export class`)
   - Anotar el nombre exacto de cada export

2. **Verificar cada import**
   - El import `{ A, B, C }` requiere que A, B, C existan como exports con nombre
   - Si es `export default`, importar con `import Nombre from` (sin llaves)
   - Si es `export const NAME`, importar con `import { NAME } from`

3. **Tabla de decisiones para exports:**

| Declaración | Export correcto | Import correcto |
|------------|-----------------|-----------------|
| `const X = 1` | ❌ No exporta | - |
| `export const X = 1` | ✅ `export const X` | `import { X } from` |
| `export function fn()` | ✅ `export function fn` | `import { fn } from` |
| `export default class C` | ✅ `export default C` | `import C from` |

## Checklist de Validación Rápida

Antes de considerar un archivo JavaScript "validado", verificar:

```
□ ¿Todos los exports tienen la palabra clave 'export'?
□ ¿Los imports usan { } si son named exports?
□ ¿Los imports NO usan { } si es export default?
□ ¿Los nombres en imports coinciden exactamente con exports?
□ ¿Las mayúsculas/minúsculas coinciden?
□ ¿El archivo game-state.js exporta CONFIG y GAME_STATES?
□ ¿Los archivos que usan CONFIG/GAME_STATES los importan correctamente?
```

## Ejemplo de Archivo Correcto

```javascript
// ✅ CORRECTO - todos los exports son explícitos
export const CONFIG = { value: 1 };
export const GAME_STATES = { A: 'a', B: 'b' };

export function getValue() { return CONFIG.value; }
export default class MiClase { }
```

```javascript
// ❌ INCORRECTO - game-state.js sin exports
const CONFIG = { value: 1 };          // ERROR: no se puede importar
const GAME_STATES = { A: 'a' };       // ERROR: no se puede importar
```

## Script de Verificación Automática

Para verificar un proyecto completo, usar este comando:

```bash
# Buscar archivos que importan CONFIG o GAME_STATES pero el archivo origen no lo exporta
grep -r "import.*CONFIG" --include="*.js" | cut -d: -f1 | sort -u
```

Luego verificar manualmente que cada archivo importado tenga el export correspondiente.

## Patrón para Detectar Errores Comunes

Buscar estos patrones en el código:

| Patrón peligroso | Señal de error |
|-----------------|----------------|
| `const CONFIG = ` | Falta `export` |
| `const GAME_STATES = ` | Falta `export` |
| `import { X }` donde X no existe como `export const X` | Import incorrecto |
| `import X from` (sin llaves) pero no hay `export default X` | Import incorrecto |

## Aplicación al Proyecto void-collector

El error original:
```
X [ERROR] No matching export in "src/game-state.js" for import "CONFIG"
```

**Causa raíz**: `game-state.js` tenía `const CONFIG = {...}` sin `export`

**Solución aplicada**:
```javascript
// ANTES (INCORRECTO):
const CONFIG = { BOUNDS: 50, ... };

// DESPUÉS (CORRECTO):
export const CONFIG = { BOUNDS: 50, ... };
```

## Métricas de Cumplimiento

- **100% de archivos** deben pasar el checklist antes de ejecutar
- **0 errores de "does not provide an export"** en consola
- **Verificación cruzada**: cada import debe tener su export correspondiente