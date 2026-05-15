# dependency-risk-assessment

// 📦 depende de: [[dependency-hygiene]], [[security-hardening]], [[zero-errors]]
// 📤 exporta a: [[rules-readme]]

## filosofia

**toda dependencia nueva es un riesgo potencial. evaluar antes de instalar.**

## checklist pre-instalacion

```
□ existe ya algo equivalente en el stdlib o proyecto?
□ la libreria tiene mantenimiento activo (commit < 6 meses)?
□ la version es estable (no alpha/beta/rc sin razona)?
□ el bundle size es aceptable?
  - frontend libs: < 50kb gzip para features no-criticas
  - backend libs: < 5MB memoria base
□ la licencia es compatible (MIT/Apache/BSD/ISC)?
□ tiene vulnerabilidades conocidas (npm audit)?
□ puedo verificar propsitos y comportamiento con codigo source?
□ alternative zero-dependency viable?
```

## maturity checklist

```
□ tiene README claro?
□ tiene tests?
□ tiene changelog o version history?
□ tiene mas de X estrellas / forks?
□ issues abiertos son addressed?
□ ultimo release < 12 meses atrs?
□ soporte para tu version de runtime?
```

## risk matrix

| Factor | Low Risk | High Risk |
|--------|----------|-----------|
| Maintenance | < 6 meses since last commit | > 1 ao sin updates |
| Downloads | > 100k weekly | < 1k weekly |
| Dependents | > 100 dependent packages | < 10 |
| Security | No known vulnerabilities | Active CVEs |
| Type Safety | Full TypeScript support | JS only, no types |
| Docs | Good coverage | Poor/no docs |

## prohibited

```
❌ is-odd, left-pad o librerias trivialis de 1 funcion
❌ Librerias con > 1MB para functionality simple
❌ Librerias abandonadas (> 2 anos sin updates)
❌ Librerias con known vulnerabilities sin patch
❌ Librerias que requieren --force o --legacy-peer-deps
❌ npm install -g para proyectos
```

## audit post-instalacion

```bash
# Despus de instalar
npm audit

# Si hay vulnerabilidades:
# High/Critical -> no usar hasta patch o buscar alternativa
# Medium -> evaluar si el riesgo es aceptable con mitigacion
# Low -> resolver en proximo sprint
```

## migration plan

```
Cuando una dependencia queda obsolete:
1. Buscar alternativa o internalizar
2. Crear adapter pattern para aislar
3. Migrar gradualmente (no big bang)
4. Mantener compatibilidad hacia atrs si es API publica
5. Deprecate con timeline واضح
```

---

✅ aplica: supply_chain_security + risk_awareness + minimalismo