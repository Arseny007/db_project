create extension pg_cron;

-- refresh представления каждую минуту:
select cron.schedule('refresh_users_with_all', '* * * * *',
                     $$ refresh materialized view concurrently users_with_all $$);