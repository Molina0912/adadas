# input-sanitization

// 📦 depende de: [[security-hardening]], [[zero-errors]]
// 📤 exporta a: [[rules-readme]]

## filosofia

**todo input externo es hostil hasta que se pruebe lo contrario.**

## fuentes de input a sanitizar

```
- body (request)
- query params
- route params
- headers
- cookies
- env vars
- archivos uploadados
- datos de terceros/APIs
- storage local/IndexedDB
```

## sanitization rules

### strings

```ts
// ❌ INCORRECTO - sin sanitizar
const name = req.body.name;
db.query(`SELECT * FROM users WHERE name = '${name}'`);

// ✅ CORRECTO - sanitizado + validated
import { z } from 'zod';
const Schema = z.string().min(1).max(100).trim();
const name = Schema.parse(req.body.name);
```

### numbers

```ts
// ❌ INCORRECTO
const age = req.body.age;
if (age > 150) // bypassable

// ✅ CORRECTO
const Schema = z.number().int().min(0).max(150);
const age = Schema.parse(req.body.age);
```

### HTML/script injection

```ts
// ❌ INCORRECTO - XSS
const comment = req.body.comment;
element.innerHTML = comment;

// ✅ CORRECTO - sanitizado
import DOMPurify from 'dompurify';
const clean = DOMPurify.sanitize(comment, { ALLOWED_TAGS: ['b', 'i'] });
```

### command injection

```ts
// ❌ INCORRECTO - command injection
const filename = req.body.filename;
exec(`cat ${filename}`);

// ✅ CORRECTO - sin exec, usar APIs natives
import { readFile } from 'fs/promises';
const filename = Schema.parse(req.body.filename);
const content = await readFile(filename, 'utf-8');
```

## checklist

```
□ todo input externo tiene schema validation?
□ ninguna interpolacion de strings en SQL sin prepared statements?
□ ninguna interpolacion en comandos shell?
□ ningun innerHTML/dangerouslySetInnerHTML sin sanitizacion?
□ ningun archivo sin validacion de tipo y tamanho?
□ ningun dato de usuario sin sanitizar antes de storage/display?
```

## validation library

Usar siempre Zod o Valibot para validacion:

```ts
import { z } from 'zod';

export const CreateUserSchema = z.object({
  email: z.string().email().trim(),
  name: z.string().min(1).max(100).trim(),
  age: z.number().int().min(0).max(150).optional(),
});
```

---

✅ aplica: owasp_a01 + input_validation + default_deny