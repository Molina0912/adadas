# ai-output-validation

// 📦 depende de: [[verify-before-claim]], [[reasoning-protocol]], [[security-hardening]]
// 📤 exporta a: [[rules-readme]]

## filosofia

**nunca confiar ciegamente en output de LLM sin validacion estructural y semantica.**

## protocolo de 3 capas

### capa 1: validacion estructural

```ts
// ✅ siempre definir schema para output esperado
import { z } from 'zod';

const LLMResponseSchema = z.object({
  answer: z.string().min(1),
  sources: z.array(z.string().url()).optional(),
  confidence: z.number().min(0).max(1),
  metadata: z.object({
    model: z.string(),
    tokens_used: z.number(),
    latency_ms: z.number()
  })
});

// validar ANTES de usar el output
const validated = LLMResponseSchema.parse(rawLLMOutput);
```

### capa 2: validacion semantica

```ts
// ✅ reglas de negocio sobre el output
function validateLLMResponse(response: LLMResponse) {
  // rango aceptable
  if (response.confidence < 0.7) {
    throw new Error('Low confidence, requires human review');
  }

  // consistencia logica
  if (response.answer.includes('not sure') && response.confidence > 0.9) {
    throw new Error('Inconsistent confidence vs answer');
  }

  // longitud razonable
  if (response.answer.length > 10000) {
    throw new Error('Answer too long, possible injection');
  }
}
```

### capa 3: validacion de seguridad

```ts
// ✅ detectar inyeccion de prompts, jailbreak, data leakage
function validateSecurity(response: LLMResponse) {
  const dangerousPatterns = [
    /ignore previous instructions/i,
    /ignore all previous rules/i,
    /system prompt: /i,
    /you are now/i,
  ];

  for (const pattern of dangerousPatterns) {
    if (pattern.test(response.answer)) {
      throw new Error('Potential prompt injection detected');
    }
  }

  // no exponer informacion sensible en logs
  if (/api[_-]?key|password|token/i.test(response.answer)) {
    throw new Error('Potential data leakage detected');
  }
}
```

## implementacion obligatoria

```
□ definir TypeScript/Zod schema para cada output esperado
□ implementar fallback humano si validacion falla > 2 veces
□ loggear intentos de validacion fallida
□ rate limiting en llamadas LLM
□ timeout en respuestas LLM
□ registrar prompt + response completo para audit
```

## checklist

```
□ schema definido para output de LLM?
□ validacion estructural aplicada?
□ validacion semantica aplicada?
□ validacion de seguridad aplicada?
□ fallback humano disponible si falla?
□ intentos fallidos loggeados?
□ rate limiting implementado?
□ timeout implementado?
```

---

✅ aplica: ai_safety + output_integrity + no_trust_without_validation