### Reiniciar psql
```
psql -d reclame_jp_development

SELECT pg_terminate_backend(pid)
FROM pg_stat_activity
WHERE datname = 'reclame_jp_development';

\q
```