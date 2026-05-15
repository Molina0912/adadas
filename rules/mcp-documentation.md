# mcp-documentation

// 📦 depende de: [[zero-errors]], [[js-module-validator]]
// 📤 exporta a: [[rules-readme]]

## regla: usar siempre documentacion mcp al crear proyectos

**aplicala siempre que crees un nuevo proyecto o escribas codigo con librerias/frameworks.**

## por que existe esta regla

los modelos de ia pueden alucinar apis, nombres de parametros y comportamientos especificos de versiones. usar documentacion oficial a traves de servidores mcp elimina este riesgo.

## servidores mcp disponibles

| servidor mcp | url | mejor para |
|--------------|-----|------------|
| **context7** | `https://mcp.context7.com/mcp` | librerias con versionado oficial (next.js 15, prisma 6, langgraph) |
| **mcp-docs** | `https://gitmcp.io/docs` | repos github, paquetes especificos, herramientas internas |

## flujo de trabajo obligatorio

### paso 1: identificar la libreria/framework
- ¿que libreria o framework usa el proyecto?
- ¿cual es la version exacta o version mayor?

### paso 2: consultar el mcp apropiado

**para context7 (librerias con docs versionadas):**
```
usar context7 para: /mongodb/mongodb-node, /vercel/next.js, /prisma/prisma, /llmsthirdparty/langchain
```

**para gitmcp (repositorios github):**
```
usar gitmcp para: github.com/{owner}/{repo}
```

### paso 3: documentar las fuentes

```
## documentacion consultada
- context7 (libreria/version): [enlace o descripcion]
- gitmcp (owner/repo): [enlace o descripcion]
```

### paso 4: verificar el codigo generado

```
□ el codigo generado coincide con la version de la documentacion?
□ las llamadas api son correctas para la version de la libreria?
□ los ejemplos son funcionales y limpios?
□ las fuentes estan citadas en la respuesta?
```

## arbol de decision: cual mcp usar?

```
¿es una libreria conocida con versionado oficial?
├── si → usar context7 (especificar version: /org/project/vx.y)
└── no
    ├── ¿es un repositorio github?
    │   ├── si → usar gitmcp (owner/repo)
    │   └── no → usar busqueda generica de mcp-docs
    └── ¿es un repositorio interno/privado?
        └── si → usar gitmcp con url especifica del repo
```

## ids de libreria en context7 (ejemplos comunes)

| libreria | id context7 |
|----------|-------------|
| three.js | `/mrdoob/three.js/r110` |
| next.js | `/vercel/next.js/v15` |
| react | `/facebook/react/v19` |
| prisma | `/prisma/prisma/v6` |
| langchain | `/llmstext/llmstxt_langchain` |

## formato para gitmcp

```javascript
// para un repositorio especifico:
mcp-docs_fetch_generic_documentation({ owner: "owner", repo: "repo" })

// para busqueda de codigo:
mcp-docs_search_generic_code({ owner: "owner", repo: "repo", query: "code search" })

// para busqueda de documentacion:
mcp-docs_search_generic_documentation({ owner: "owner", repo: "repo", query: "docs search" })
```

## formato para context7

```javascript
// paso 1: resolver id de libreria
context7_resolve-library-id({ libraryname: "libraryname", query: "search query" })

// paso 2: consultar documentacion
context7_query-docs({ libraryid: "/org/project/v1.0", query: "your question" })
```

## errores comunes a evitar

| error | por que esta mal |
|-------|------------------|
| "usare mi conocimiento de react" | las versiones de react difieren significativamente; la api cambia |
| "creo que funciona asi..." | las suposiciones llevan a codigo alucinado |
| "esta sintaxis se ve correcta" | sin verificar docs, puede estar completamente mal |
| omitir docs por ser "proyecto simple" | incluso proyectos simples usan librerias que cambian |

## checklist anti-alucinacion

```
□ consultaste context7 o gitmcp para la libreria principal?
□ el id/version de la libreria es correcto?
□ el codigo generado coincide con las docs verificadas?
□ estas citando las fuentes en la respuesta?
□ verificaste que el codigo compila/ejecuta sin errores?
```

## proyecto void-collector (aplicado)

**librerias usadas**: three.js

**consultas mcp realizadas**:
- `context7_resolve-library-id`: three.js → `/mrdoob/three.js`
- `context7_query-docs`: webgl renderer, scene, camera, raycasting examples
- `mcp-docs_match_common_libs_owner_repo_mapping`: three.js → mrdoob/three.js
- `mcp-docs_search_generic_documentation`: webgl game tutorial

**resultado**: ✅ codigo generado coincide con three.js r110 api

**fuentes citadas**:
- context7: `webgl_buffergeometry_constructed_from_geometry.html`, `webgl_interactive_cubes.html`
- gitmcp: `creating-a-scene.html`, `fundamentals.html`, `webglrenderer.html`

---

**recordatorio**: "verifica primero con mcp, luego genera codigo. nunca asumas apis."

✅ reglas aplicadas: minúsculas + modularidad + trazabilidad_[[wiki]] + mcp_obligatorio