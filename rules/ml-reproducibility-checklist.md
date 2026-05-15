# ml-reproducibility-checklist

// 📦 depende de: [[zero-errors]], [[mcp-documentation]], [[decision-log]]
// 📤 exporta a: [[rules-readme]]

## filosofia

**todo experimento de ML/IA debe ser 100% reproducible desde cero.**

## checklist REFORMS

### reproducibility

```
□ seed fija en todos los componentes aleatorios
□ versionado de datos (DVC o similar)
□ versionado de codigo (git tag + commit hash en metadatos)
□ versionado de entorno (requirements.txt + Dockerfile)
□ metricas registradas con contexto (dataset, hiperparametros)
□ artefactos guardados con checksum para verificacion
```

### randomness control

```python
# ✅ TODA fuente de aleatoriedad debe tener seed fija
import numpy as np
import random
import torch

SEED = 42

def set_seed(seed=SEED):
    random.seed(seed)
    np.random.seed(seed)
    torch.manual_seed(seed)
    torch.cuda.manual_seed_all(seed)
    torch.backends.cudnn.deterministic = True
    torch.backends.cudnn.benchmark = False

set_seed()
```

### data versioning

```yaml
# dvc.yaml
datasets:
  training_data:
    path: data/train.csv
    hash: sha256:abc123...
    version: v2.1
  validation_data:
    path: data/val.csv
    hash: sha256:def456...
    version: v2.1
```

### experiment tracking

```python
# ✅ registrar TODO con MLflow o similar
import mlflow

mlflow.start_run(run_name="experiment_001"):
    mlflow.log_param("model_type", "xgboost")
    mlflow.log_param("learning_rate", 0.01)
    mlflow.log_param("n_estimators", 100)
    mlflow.log_param("seed", SEED)
    mlflow.log_metric("accuracy", 0.87)
    mlflow.log_metric("f1", 0.85)
    # guardar artefacto
    mlflow.log_artifact("model.pkl")
```

### environment lock

```dockerfile
# ✅ entorno versionado
FROM python:3.11-slim
COPY requirements.txt .
RUN pip install -r requirements.txt --no-cache-dir

# requirements.txt debe tener versiones exactas
# numpy==1.24.0
# pandas==2.0.0
# torch==2.0.0
```

## prohibited

```
❌ "funciona en mi maquina" sin especificar entorno
❌ resultados sin registrar hiperparametros exactos
❌ modelos entrenados con datos no versionados
❌ aleatoriedad sin seed fija
❌ dependencias sin versiones en requirements.txt
```

## checklist final de reproducibility

```
□ puedes recrear el experimento desde cero con solo el codigo y datos versionados?
□ el seed esta fijo en TODOS los componentes (numpy, torch, random)?
□ los datos tienen hash unico para verificacion?
□ el entorno esta containerizado o versionado exactamente?
□ los hiperparametros exactos estan registrados?
□ las metricas incluyen dataset y version usados?
```

---

✅ aplica: ml_reproducibility + ciencia_abierta + auditabilidad