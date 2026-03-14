# Database Dump Sync

Este directorio contiene el dump SQL versionado para sincronizar estructura/datos al VPS durante el deploy.

Archivo esperado por el workflow:

- `database/deploy/temp.sql`

Generar dump completo (estructura + datos):

```bash
bash scripts/generate-db-dump.sh
```

Generar solo estructura:

```bash
ONLY_STRUCTURE=1 bash scripts/generate-db-dump.sh
```
