# self-review

// 📦 depende de: [[zero-errors]], [[reasoning-protocol]]
// 📤 exporta a: [[rules-readme]]

## filosofia

**despues de cada cambio: revisate a ti mismo como lo harias con codigo ajeno.**

## checklist de self-review

### correctitud
```
□ hace lo que se pidio exactamente?
□ los edge cases estan cubiertos?
□ null/undefined/empty manejados?
□ no hay regression en funcionalidad existente?
```

### arquitectura
```
□ respeta [[domain-driven-boundaries]]?
□ no hay [[anti-side-effects]]?
□ los imports son claros y necesarios?
□ la responsabilidad es unica por archivo?
```

### seguridad
```
□ alguna vulnerability de OWASP Top 10?
□ input sanitizado (ver [[input-sanitization]])?
□ secretos en variables de entorno?
□ ninguna credencial hardcodeada?
```

### performance
```
□ queries optimizadas (no N+1)?
□ indexes necesarios?
□ lazy loading donde corresponde?
□ bundle size no excedio budget?
```

### mantenibilidad
```
□ el codigo es legible por otros?
□ los nombres son descriptivos?
□ los comentarios son utiles?
□ la documentacion actualizada?
□ los tests cubren el cambio?
```

## proceso adversarial

Intentá romper tu propia solucion antes de reportar:

```
□ que pasa con input vacio?
□ que pasa con input muy largo?
□ que pasa con caracteres especiales (', ", <, >, ;)
□ que pasa si la dependencia falla?
□ que pasa en race conditions?
□ que pasa en concurrent requests?
□ que pasa si el cache esta corrupto?
```

## señales de auto-critica

```
- "esto funciona pero no es elegante" -> refactor antes de reportar
- "este hack funciona por ahora" -> abrir tech debt issue
- "esto deberia andar" -> verificar con tests
- "es obvio" -> quizas no lo es para otros, documentar
```

---

✅ aplica: auto-auditoria + calidad_sin_compasion + mejora_continua