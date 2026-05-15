# dependency-hygiene

// 📦 depende de: [[mcp-documentation]]

## regla

**toda dependencia nueva exige justificacion y verificacion.**

## checklist obligatorio antes de instalar

```
□ ¿existe ya algo equivalente en el proyecto o stdlib?
□ ¿la libreria tiene mantenimiento activo (commit < 12 meses)?
□ ¿la version es estable (no alpha/beta sin razon)?
□ ¿el bundle size es aceptable (< 50kb gzip para frontend)?
□ ¿la licencia es compatible (MIT/Apache/BSD)?
□ ¿consulte docs oficiales via context7/gitmcp?
□ ¿hay alternativa zero-dep razonable?
```

## prohibido

- agregar libreria de 200kb por una funcion de 5 lineas (`is-odd`, `left-pad`, etc.)
- `npm install -g` en proyectos
- mezclar gestores (npm + yarn + pnpm + bun en el mismo repo)
- actualizar versiones mayores sin leer changelog
- `--force` o `--legacy-peer-deps` sin entender que oculta

## reportar al usuario

al agregar dep nueva, incluir en la respuesta:

```
nueva dependencia: <nombre>@<version>
razon: <para que se usa>
tamaño: <bundle size>
alternativas consideradas: <lista>
```

## auditoria

despues de instalar, ejecutar `npm audit` (o equivalente). reportar vulnerabilidades altas/criticas al usuario.

---

✅ aplica: minimalismo + supply_chain_security
