---
name: zero-errors
description: Reglas anti-spaghetti y zero errors. Incluye checklist de verificación obligatoria, proceso de 6 fases, límites de líneas (150/archivo, 30/función), archivos prohibidos, verificación anti-archivo-monstruo, herramientas de verificación automatizada (SAST, linters, formateadores), y estándares ISO/IEC para calidad de software.
---

# SKILL: ZERO ERRORS + ANTI-SPAGHETTI CODE v5.0

## Reglas Anti-Spaghetti (CRÍTICO)

### Límites Absolutos
- **MAX 150 líneas** por archivo
- **MAX 30 líneas** por función
- **MAX 10 imports** por archivo
- **MAX 5 funciones exportadas** por archivo
- **MAX 4 argumentos** por función

### Archivos PROHIBIDOS (NUNCA crear)
❌ utils.ts, helpers.ts, manager.ts, handler.ts, functions.ts, lib.ts, core.ts, main.ts, utilities.ts, misc.ts, shared.ts, common.ts, index.ts (catch-all)

---

## 🚫 CHECKLIST ANTI-SPAGHETTI - OBLIGATORIA

### Sección A: Límites de Tamaño
```
□ ¿Archivo < 150 líneas?
□ ¿Función más larga < 30 líneas?
□ ¿Imports < 10?
□ ¿Argumentos < 4?
```

### Sección B: Archivos Prohibidos
```
□ ¿NO es archivo prohibited?
□ ¿Nombre es descriptivo (noun-verb)?
```

### Sección C: Single Responsibility
```
□ ¿UNA responsabilidad clara?
□ ¿Puedo mover a otra carpeta sin romper?
□ ¿Código dividido por dominio?
```

### Sección D: Modularidad y Arquitectura
```
□ ¿Desacoplamiento entre componentes?
□ ¿Abstracción para aislar cambios?
□ ¿Interfaces bien definidas?
□ ¿Estructura de carpetas correcta?
```

### Sección E: Nomenclatura
```
□ ¿Nombres descriptivos? (no a, b, c, temp)
□ ¿Funciones: verb-noun?
□ ¿Archivos: noun-noun?
```

### Verificación Final
```
╔═══════════════════════════════════════════════════════════════╗
║  SECCIÓN A - Límites:         [ ] PASS [ ] FAIL            ║
║  SECCIÓN B - Prohibidos:      [ ] PASS [ ] FAIL            ║
║  SECCIÓN C - Responsabilidad: [ ] PASS [ ] FAIL            ║
║  SECCIÓN D - Modularidad:     [ ] PASS [ ] FAIL            ║
║  SECCIÓN E - Nomenclatura:    [ ] PASS [ ] FAIL            ║
║                                                               ║
║  RESULTADO: [ ] TODO PASÓ - PUEDES ENTREGAR                  ║
║            [ ] FALLÓ - REFACTORIZA ANTES DE ENTREGAR         ║
╚═══════════════════════════════════════════════════════════════╝
```

SI CUALQUIERA ES «NO» → DETENERSE Y REFACTORIZAR

---

## 🛠️ HERRAMIENTAS DE VERIFICACIÓN AUTOMATIZADA

### Formateadores (Estilo Consistente)
| Herramienta | Lenguaje | Comando |
|-------------|----------|---------|
| `black` | Python | `black .` |
| `prettier` | JS/TS | `prettier --write .` |
| `rustfmt` | Rust | `rustfmt` |
| `gofmt` | Go | `gofmt -w .` |

### Linters (Análisis Estático)
| Herramienta | Lenguaje | Propósito |
|-------------|----------|-----------|
| `flake8` | Python | Errores de estilo, pep8 |
| `pylint` | Python | Análisis profundo, code smells |
| `ESLint` | JS/TS | Errores, anti-patrones |
| `Qodana` | Multi | Inspección JetBrains en CI |

### SAST - Análisis de Seguridad
| Herramienta | Propósito |
|-------------|----------|
| `Bandit` | Debilidades de seguridad Python |
| `CodeQL` | Análisis profundo de dependencias |
| `Semgrep` | Reglas personalizadas de detección |
| `SonarQube` | Calidad y seguridad integrada |

### Verificadores de Tipos
| Herramienta | Lenguaje | Propósito |
|-------------|----------|-----------|
| `mypy` | Python | Verificación de tipos estáticos |
| `ty` | Python | Verificador ultra rápido (Rust) |
| `Pyright` | Python | Análisis de tipos rápido |
| `TypeScript` | JS/TS | Tipado integrado |

### Pipeline de Verificación Recomendado
```bash
# Python
black . && flake8 . && mypy . && bandit -r .

# JavaScript/TypeScript
prettier --check . && ESLint . && tsc --noEmit

# Ejecutar ANTES de cada commit (pre-commit hook)
```

---

## 📐 ESTÁNDARES INTERNACIONALES DE CALIDAD

### ISO/IEC 42010 - Arquitectura de Sistemas
- Marco para descripciones arquitectónicas
- Vocabulario y conceptos consistentes
- Comunicación clara entre stakeholders

### ISO/IEC 25010 - Calidad de Software
| Característica | Descripción |
|----------------|-------------|
| **Mantenibilidad** | Modularidad, analysabilidad, modificabilidad |
| **Fiabilidad** | Madurez, disponibilidad, tolerancia a fallos |
| **Usabilidad** | Comprensibilidad, aprendibilidad, operabilidad |
| **Rendimiento** | Comportamiento temporal, utilización de recursos |

### Referencia para Evaluación
```
ISO/IEC 25010 → Evaluar la salud arquitectónica
ISO/IEC 42010 → Documentar decisiones de diseño
```

---

## 🧪 PARA PROYECTOS DE ML/IA - MLOps Checklist

### Reproducibilidad (OBLIGATORIO)
```
□ ¿Mismo código + mismo dataset = mismo resultado?
□ ¿Features de entrada registradas?
□ ¿Pipeline de entrenamiento = pipeline de inferencia?
□ ¿Versiones de dependencias documentadas?
```

### Documentación de Modelo
```
□ Machine Learning Canvas completado
□ REFORMS checklist (32 items) aplicado
□ Hyperparámetros documentados
□ Dataset de validación separado
```

### Plataformas MLOps Soportadas
| Componente | Herramientas |
|------------|--------------|
| Versionado | DVC, Git LFS |
| Experimentos | MLflow, Neptune, W&B |
| Pipelines | Kubeflow, Airflow, SageMaker |
| Despliegue | TensorFlow Serving, TorchServe, Seldon |
| Monitorización | Prometheus, Grafana, Evidently |

---

## 📋 Reglas Zero Errors

1. **VERIFICAR antes de escribir código** - Confirmar que entiendes el problema
2. **NUNCA inventar** - No crear APIs o funciones que no existan
3. **SEGURIDAD primero** - Verificar contra OWASP Top 10
4. **MANEJO de incertidumbre** - Detenerse y preguntar si hay duda
5. **DECIR «NO SÉ»** cuando falta información crítica

---

## 🔄 Proceso de 6 Fases

1. **ANÁLISIS** - Documentar problema, inputs, outputs, edge cases
2. **DISEÑO ESTRUCTURAL** - Definir archivos y carpetas (TODOS < 150 líneas)
3. **IMPLEMENTACIÓN** - Código siguiendo reglas, tipado estricto
4. **VERIFICACIÓN SPAGHETTI** - Checklist anti-spaghetti (Secciones A-E)
5. **VERIFICACIÓN ZERO ERRORS** - Checklist + herramientas automatizadas
6. **ENTREGA** - Explicar estructura, limitaciones, próximos pasos

---

## 🛑 Stop Conditions

DETENERSE si:
- Usuario pide archivo único que haga todo
- Usuario pide archivos prohibidos
- Información crítica faltante
- Código podría causar daño
- Estructura sería spaghetti code
- Proyecto ML sin verificacion de reproducibilidad

---

**VERSION:** 5.0
**ULTIMA ACTUALIZACIÓN:** 2025-05-14
**FEATURES:** Zero Errors + Anti-Spaghetti + SAST + MLOps + ISO Standards
**HERRAMIENTAS:** black, flake8, mypy, bandit, prettier, ESLint, Qodana