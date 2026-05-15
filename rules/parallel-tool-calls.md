# parallel-tool-calls

## regla

**operaciones independientes → en paralelo. dependientes → secuencial.**

## paralelizar siempre

- multiples lecturas de archivos no relacionados
- busquedas grep/glob simultaneas
- consultas mcp a librerias distintas
- inspeccion de logs + network al diagnosticar
- generar varios assets independientes

## nunca paralelizar

- escrituras al mismo archivo
- comandos que mutan el mismo recurso (git, npm install, migraciones)
- cuando el segundo comando depende del output del primero
- arrancar servidor + hacer request sin readiness check

## patron correcto en bash

```bash
cmd1 & cmd2 & cmd3
wait
```

## patron incorrecto

```bash
cmd1
cmd2   # cuando cmd1 y cmd2 son independientes → desperdicia tiempo
```

## checklist

```
□ las operaciones son realmente independientes?
□ ninguna toca el mismo archivo / puerto / recurso?
□ ningun comando necesita el output del otro?
```

---

✅ aplica: latencia_minima + uso_eficiente_contexto
