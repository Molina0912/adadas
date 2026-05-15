# rollback-strategy

// 📦 depende de: [[zero-errors]], [[task-decomposition]]
// 📤 exporta a: [[rules-readme]]

## filosofia

**nunca hacer cambio riesgoso sin rollback plan.**

## cuando aplica

```
□ cambio en archivo unico que requiere mas de 30 min de trabajo
□ cambios en base de datos (migration)
□ cambios en API publica (breaking change)
□ cambios en archivos de configuracion globally-shared
□ upgrade de dependencia mayor
□ refactor que toca > 5 archivos
□ cualquier cambio que no pueda deshacerse facilmente con git
```

## rollback plan template

```
## cambio planeado
[descripcion breve]

## archivos afectados
- [lista de archivos]

## backup
[como respaldar antes del cambio]
- comando: git stash o cp -r

## rollback procedure
1. [paso 1]
2. [paso 2]
3. ...

## verificacion post-rollback
- [ ] compilacion exitosa
- [ ] tests pasan
- [ ] funcionalidad-basica trabaja

## tiempo maximo para rollback
[estimado en minutos]
```

## checklist pre-cambio

```
□ tienes backup de archivos que vas a cambiar?
□ tienes rollback plan documentado?
□ conoces el comando exacto para revertir?
□ sabes que archivos tocaras?
□ tienes manera de verificar que rollback funciono?
□ alguien sabe que estas haciendo el cambio?
```

## commands de rollback

### git rollback (undo uncommit)

```bash
git revert HEAD
```

### git rollback (undo cambios sin commit)

```bash
git checkout -- archivo
```

### npm rollback

```bash
npm install package@version-anterior
```

### migration rollback

```bash
npm run migrate:down
```

## signals de abort

```
□ rollback plan no compile
□ no tienes forma de verificar que revertiste bien
□ el cambio es irreversible de naturaleza (drop table, delete resource)
□ no tienes permisos para hacer el cambio
```

En estos casos: **stop-and-ask.**

---

✅ aplica: riesgo_controlado + recovery_plan + abort_decision