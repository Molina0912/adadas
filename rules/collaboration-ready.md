# collaboration-ready

// 📦 depende de: [[zero-errors]], [[documentation-as-code]]
// 📤 exporta a: [[rules-readme]]

## filosofia

**codigo escrito para otros humanos. comentarios que explican POR QUE, no QUE. naming que hace el codigo auto-documentado.**

## reglas de comments

### correcto

```ts
// ✅ explica el WHY, no el WHAT
// Necesario porque el API de pago requiere el monto en centavos
const amountCents = priceUsd * 100;

// ✅ explica una decision no obvia
// Usamos burbuja porque para n < 50 el overhead de quicksort no vale la pena
const sorted = bubbleSort(arr); // arr casi siempre tiene < 50 elementos

// ✅ senala riesgos
// TODO: remover cuando AuthService v2 este disponible (Q3 2024)
const token = legacyAuthFlow(tokenInput);
```

### prohibido

```ts
// ❌ NO explica lo que ya es obvio
const x = 5; // x = 5

// ❌ NO comentarios que contradicen el codigo
// Esto no hace nada malo (pero si lo hace - bug)
const data = process(sensitiveData);

// ❌ NO dejar comentarios como pseudocodigo y olvidarlos
//应该有更优雅的写法
function process() { ... }
```

## naming auto-documentado

```ts
// ❌ VAGUE naming
const data = getData();
const result = process(data);
const temp = calculate(x, y);

// ✅ DESCRIPTIVE naming
const rawUserInput = getData();
const validatedEmail = process(rawUserInput);
const distanceKm = calculateDistance(pointA, pointB);
```

## structure for onboarding

```
modulo/
├── README.md              # Quick start + purpose
├── index.ts               # Public API seule
├── domain/                # Business logic (pure)
│   ├── types.ts
│   └── services.ts
├── __tests__/             # examples + tests
└── docs/                  # architectural decisions
```

## checklist

```
□ los comentarios explican POR QUE, no QUE?
□ el naming es descriptivo sin abreviaturas crípticas?
□ cada modulo tiene README con quick start?
□ los tests sirven como documentacion ejecutable?
□ la estructura facilita el onboarding?
□ no hay comentarios en idiomas mezclados?
```

---

✅ aplica: codigo_legible + onboarding_rapido + comentarios_utiles