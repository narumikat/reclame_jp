### Reiniciar psql
```
psql -d reclame_jp_development

SELECT pid, usename, application_name, client_addr, backend_start, state, query
FROM pg_stat_activity
WHERE datname = 'reclame_jp_development';

SELECT pg_terminate_backend(pid)
FROM pg_stat_activity
WHERE datname = 'reclame_jp_development' AND pid <> pg_backend_pid();


\q
```