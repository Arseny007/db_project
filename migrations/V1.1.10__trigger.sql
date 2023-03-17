drop function if exists refresh_users_with_all;
create function refresh_users_with_all()
    returns trigger as
$$
begin
    refresh materialized view concurrently users_with_all;

    return new;
end;
$$
    language 'plpgsql';

create trigger update_users_table
    after insert or update or delete
    on users
    for each row
execute function refresh_users_with_all();
