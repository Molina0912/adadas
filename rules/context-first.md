# context-first

// 📦 depende de: [[zero-errors]]
// 📤 exporta a: [[rules-readme]]

## regla

**nunca editar a ciegas. nunca crear duplicados.**

## antes de modificar un archivo

```
□ leiste el archivo completo (no solo la zona a tocar)?
□ entendiste sus imports y a quien exporta?
□ verificaste que la edicion no rompe consumidores?
```

## antes de crear un archivo

```
□ ejecutaste grep/glob buscando funcionalidad similar?
□ revisaste convenciones del proyecto (naming, estructura)?
□ confirmaste que no existe ya un modulo equivalente?
```

## prohibido

- editar basandose en el nombre del archivo sin abrirlo
- crear `auth.ts` cuando ya existe `authenticate-user.ts`
- asumir el contenido de `package.json`, `tsconfig`, `.env` sin leerlos
- hacer cambios masivos sin mapear primero las dependencias

## condiciones de parada

si tras leer descubres que el cambio impacta >5 archivos no mencionados por el usuario → **detente y reporta** antes de continuar.

---

✅ aplica: lectura_obligatoria + verificacion_pre_cambio
