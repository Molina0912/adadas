# zero-errors rule

// 📦 depende de: [[js-module-validator]], [[mcp-documentation]]
// 📤 exporta a: [[zero-errors-skill]], [[agents-zero-errors]]

## filosofia

"cada archivo debe poder vivir solo. si no puedes mover un archivo a otra carpeta sin romper cosas, esta mal diseniado."

## limites absolutos

| metrica | maximo |
|---------|--------|
| lineas por archivo | 150 |
| lineas por funcion | 30 |
| imports por archivo | 10 |
| funciones exportadas | 5 |
| argumentos por funcion | 4 |

## archivos prohibidos (nunca crear)

```
❌ utils.ts, helpers.ts, manager.ts, handler.ts
❌ functions.ts, lib.ts, core.ts, main.ts
❌ utilities.ts, misc.ts, shared.ts, common.ts
❌ index.ts (catch-all)
```

## nomenclatura obligatoria

```
✅ correcto:
- user-validator.ts      (sustantivo + proposito)
- authenticate-user.ts   (verbo + sustantivo)
- user-repository.ts    (sustantivo + patron)
- send-password-reset.ts (verbo + sustantivo + contexto)

❌ incorrecto:
- utils.ts              (vago)
- process.js            (vago)
- handler.ts            (vago)
- manager.ts            (vago)
- UserValidator.ts      (prohibido mayusculas)
- AUTH_SERVICE.ts       (prohibido mayusculas)
```

## checklist de verificacion

### seccion a: limites de tamano
```
□ archivo < 150 lineas?
□ funcion mas larga < 30 lineas?
□ imports < 10?
□ argumentos < 4?
```

### seccion b: nomenclatura
```
□ todo en minúsculas?
□ ningun camelcase/pascalcase?
□ nombre descriptivo (verbo-sustantivo para funciones)?
```

### seccion c: archivos prohibidos
```
□ no es utils.ts, helpers.ts, manager.ts, handler.ts?
□ no es functions.ts, lib.ts, core.ts, main.ts?
□ no es utilities.ts, misc.ts, shared.ts, common.ts?
□ no es index.ts (catch-all)?
```

### seccion d: responsabilidad unica
```
□ una responsabilidad clara?
□ dividido por dominio?
□ puedes mover a otra carpeta sin romper?
```

### seccion e: memoria (post-cambio)
```
□ leyo todo el proyecto despues del cambio?
□ documentacion actualizada?
□ apis consistentes con implementaciones?
□ sin enlaces rotos o referencias huerfanas?
```

### seccion f: arquitectura (proyectos ia)
```
□ desacoplamiento entre componentes?
□ abstraccion para aislar cambios?
□ pipelines reproducibles (entrenamiento = inferencia)?
□ modulos con responsabilidades claras?
```

### seccion g: seguridad (owasp top 10 + zero trust)
```
□ autenticacion por identidad de usuario (oidc/saml)?
□ autenticacion por identidad de servicio (spiffe)?
□ credenciales canonicalizadas en gateway?
□ limitacion de tasas implementada?
□ validacion estricta de inputs?
```

### seccion h: calidad de texto
```
□ no hay texto duplicado en archivos?
□ no hay caracteres extranos (? ? caracteres chinos involuntarios)?
□ codificacion utf-8 consistente?
□ texto en idioma correcto (espanol)?
□ sin valores hardcoded que deberian ser variables de entorno?
□ comentarios descriptivos y utiles?
```

### seccion i: trazabilidad [[wiki]]
```
□ cada archivo tiene bloque de cabecera con [[ ]]?
□ los [[ ]] coinciden 1:1 con imports reales?
□ todos los nombres en [[ ]] estan en minusculas y sin extension?
□ ningun [[ ]] dentro de codigo ejecutable?
□ estructura con bajo acoplamiento (max 3-4 dependencias directas)?
```

## verificacion final

```
╔═══════════════════════════════════════════════════════════════╗
║  SECCION A - Limites:         [ ] pass [ ] fail            ║
║  SECCION B - Nomenclatura:    [ ] pass [ ] fail            ║
║  SECCION C - Prohibidos:      [ ] pass [ ] fail            ║
║  SECCION D - Responsabilidad:[ ] pass [ ] fail            ║
║  SECCION E - Memoria:         [ ] pass [ ] fail            ║
║  SECCION F - Arquitectura IA: [ ] pass [ ] fail            ║
║  SECCION G - Seguridad:       [ ] pass [ ] fail            ║
║  SECCION H - Calidad texto:   [ ] pass [ ] fail            ║
║  SECCION I - Trazabilidad:    [ ] pass [ ] fail            ║
║                                                               ║
║  result: [ ] todos pass - listo para entregar              ║
║          [ ] failed - refactorizar antes de entregar       ║
╚═══════════════════════════════════════════════════════════════╝
```

## condiciones de parada

**detenerte y preguntar si:**

1. usuario pide un solo archivo que haga todo
2. usuario pide archivos prohibidos
3. informacion critica faltante
4. codigo podria causar dano
5. estructura seria spaghetti code
6. cambio rompe consistencia del proyecto
7. documentacion necesaria faltante
8. proyecto ia sin verificacion de reproducibilidad

---

✅ reglas aplicadas: nomenclatura_minusculas + arquitectura_modular + enlaces_[[wiki]] + separacion_por_archivos