# state-management-discipline

// 📦 depende de: [[zero-errors]], [[domain-driven-boundaries]]
// 📤 exporta a: [[rules-readme]]

## filosofia

**estado local primero. global solo si es necesario. derived state prohibido si puede calcularse.**

## jerarquia de estado

```
1. estado local (useState/useRef) - preferido
2. estado lifted (props drilling) - cuando es necesario
3. contexto modulo ( Context API / signals ) - sparingly
4. estado global ( redux/zustand ) - ultimo recurso
```

## reglas concretas

### estado local primero

```tsx
// ✅ CORRECTO - estado local si solo el componente lo usa
function UserCard({ user }) {
  const [expanded, setExpanded] = useState(false);
  // ...
}
```

### lifted state cuando se comparte entre 2-3 componentes

```tsx
// ✅ CORRECTO - lifted state si siblings lo necesitan
function Parent() {
  const [filter, setFilter] = useState('all');
  return <><List filter={filter} /><FilterBar filter={filter} onFilter={setFilter} /></>;
}
```

### global state solo cuando realmente es global

```tsx
// ❌ INCORRECTO - global para algo local
const useAuthStore = create((set) => ({
  lastClickedButton: null, // esto no necesita ser global
}));

// ✅ CORRECTO - global para algo genuinamente global
const useAuthStore = create((set) => ({
  userId: null, // esto si necesita ser global
  permissions: [],
}));
```

### derived state prohibido si puede calcularse

```tsx
// ❌ INCORRECTO - estado derivado redundante
const [users, setUsers] = useState([]);
const [userCount, setUserCount] = useState(0); // derivado, no necesario

// ✅ CORRECTO - calcular de la fuente
const [users, setUsers] = useState([]);
const userCount = users.length; // calcular, no almacenar

// ❌ INCORRECTO - actualizar derivado manualmente
useEffect(() => {
  setUserCount(users.length);
}, [users]);
```

## checklist

```
□ el estado es realmente necesario o puede calcularse?
□ si es global, es porque es realmente global?
□ no hay derived state almacenado innecesariamente?
□ el estado se limpia cuando ya no es necesario?
□ no hay estado global para datos de session/per-request?
□ los efectos que actualizan estado tienen dependencias correctas?
```

## memoization

```tsx
// ✅ CORRECTO - usar useMemo para calculos pesados
const sortedUsers = useMemo(
  () => [...users].sort((a, b) => a.name.localeCompare(b.name)),
  [users]
);

// ✅ CORRECTO - usar useCallback para closures en deps
const handleClick = useCallback(() => {
  onSelect(user.id);
}, [user.id, onSelect]);
```

---

✅ aplica: estado_minimo + predictibilidad + performance