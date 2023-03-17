drop index if exists matview_index;
create unique index matview_index on users_with_all (uid, aid);

refresh materialized view concurrently users_with_all;