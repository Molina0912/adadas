# hallucination-prevention

// 📦 depende de: [[verify-before-claim]], [[mcp-documentation]], [[reasoning-protocol]]
// 📤 exporta a: [[rules-readme]]

## filosofia

**nunca afirmar algo que no puedas verificar. si no estas seguro, busca o pregunta.**

## regla

**toda afirmacion tecnica requiere fuente verificable. si no existe, indicar uncertainty.**

## niveles de certeza

| nivel | accion |
|-------|--------|
| 100% seguro | ejecutar/proponer directo, citing fuente |
| 90-99% | ejecutar con caveat "generalmente", verificar post-ejecucion |
| 70-89% | ejecutar con warning explicito, sugerir verificacion |
| < 70% | stop-and-ask o consultar docs/MCP |

## prohibiciones absolutas

```
❌ "esta API existe y funciona asi"
❌ "este metodo acepta el parametro X"
❌ "esta sintaxis es correcta"
❌ "esta version tiene feature Y"
❌ "esto es imposible / nunca ocurre"
```

Todas estas afirmaciones requieren verificacion con MCP o docs reales.

## protocolo anti-alucinacion

### paso 1: evaluar certeza

```
□ tengo documentacion oficial para esto?
□ tengo experiencia directa con esta API/version?
□ puedo verificar con context7/gitmcp ahora mismo?
□ hay tests que prueben este comportamiento?
```

### paso 2: si no esta seguro

```
□ consultar context7 para la libreria/version especifica
□ consultar gitmcp para repositorios github
□ buscar en docs oficiales
□ ejecutar codigo de prueba para verificar
□ indicar explicitamente: "no estoy seguro, verificando..."
```

### paso 3: citing sources

```
Respuesta con fuente:
"Segun context7 para /react/v19, useEffect recibe 2 argumentos:
useEffect(() => { ... }, [deps])
 - fuente: context7:web_hooks.html"
```

## checklist

```
□ toda API/metodo/sintaxis citada tiene fuente verificable?
□ se consultaron context7 o gitmcp para librerias?
□ se Indicaron niveles de confianza < 100%?
□ no se inventaron propiedades de objetos o metodos?
□ los ejemplos de codigo fueron verificados o marcadores como pseudocodigo?
```

## senales de alucinacion

```
□ explicacion demasiado perfecta sin caveats
□ uso de palabras como "siempre", "nunca", "imposible"
□ detalles de implementacion internos de librerias sin fuente
□ versiones especificas con features sin verificar
□ errores que "nunca ocurren" pero pueden ocurrir
```

Si detectas alucinacion propia o del modelo: **corregir inmediatamente**.

---

✅ aplica: precision + honestidad + no_inventar