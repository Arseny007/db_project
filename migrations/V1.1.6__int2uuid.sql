begin;

drop materialized view users_with_all cascade;

create extension if not exists "uuid-ossp";
-- 1. - для связи таблиц users и articles2users
-- 2. - для связи таблиц articles и articles2users
-- 3. - для связи таблиц users и comments
-- 4. - для связи таблиц articles и comments
-- .? - шаги для каждой связи

-- 1.1
alter table articles2users
    drop constraint articles2users_userid_fkey;

-- 1.2
alter table articles2users
    rename column userid to old_userid;

-- 1.3
alter table articles2users
    add column userid uuid;

-- 2.1
alter table articles2users
    drop constraint articles2users_articleid_fkey;

-- 2.2
alter table articles2users
    rename column articleid to old_articleid;

-- 2.3
alter table articles2users
    add column articleid uuid;

-- 3.1
alter table comments
    drop constraint comments_userid_fkey;

-- 3.2
alter table comments
    rename column userid to old_userid;

-- 3.3
alter table comments
    add column userid uuid;

-- 4.1
alter table comments
    drop constraint comments_articleid_fkey;

-- 4.2
alter table comments
    rename column articleid to old_articleid;

-- 4.3
alter table comments
    add column articleid uuid;

-- 1.4, 3.4
alter table users
    drop constraint users_pkey;

-- 1.5, 3.5
alter table users
    rename column uid to old_uid;

-- 1.6, 3.6
alter table users
    add column uid uuid default uuid_generate_v4();

-- 2.4, 4.4
alter table articles
    drop constraint articles_pkey;

-- 2.5, 4.5
alter table articles
    rename column aid to old_aid;

-- 2.6, 4.6
alter table articles
    add column aid uuid default uuid_generate_v4();

-- 1.7, 3.7
do
$$
    declare
        row record;
    begin
        for row in select * from users
            loop
                update articles2users set userid = row.uid where old_userid = row.old_uid;
                update comments set userid = row.uid where old_userid = row.old_uid;
            end loop;
    end
$$;

-- 2.7, 4.7
do
$$
    declare
        row record;
    begin
        for row in select * from articles
            loop
                update articles2users set articleid = row.aid where old_articleid = row.old_aid;
                update comments set articleid = row.aid where old_articleid = row.old_aid;
            end loop;
    end
$$;

-- 1.8, 3.8
alter table users
    drop column old_uid;

-- 1.9, 3.9
alter table users
    add primary key (uid);

-- 2.8, 4.8
alter table articles
    drop column old_aid;

-- alter table Articles   
--     drop constraint articles_pkey;

-- 2.9, 4.9
alter table articles
    add constraint article_id_pkey primary key (aid);

-- 1.10
alter table articles2users
    drop column old_userid;

-- 2.10
alter table articles2users
    drop column old_articleid;

-- 3.10
alter table comments
    drop column old_articleid;

-- 4.10
alter table comments
    drop column old_userid;

-- 1.11
alter table articles2users
    add constraint articles2users_userid_fkey foreign key (userid) references users;

-- 2.11
alter table articles2users
    add constraint articles2users_articleid_fkey foreign key (articleid) references articles;

-- 3.11
alter table comments
    add constraint comments_userid_fkey foreign key (userid) references users;

-- 4.11
alter table comments
    add constraint comments_articleid_fkey foreign key (articleid) references articles;

-- установка некоторых сброшенных ограничений
alter table articles2users
    alter column userid set not null;

alter table users
    alter column uid set not null;

alter table articles
    alter column aid set not null;

alter table articles2users
    add constraint uq_userid_to_articleid unique (userid, articleid);

alter table articles2users
    add constraint a2u_pkey primary key (userid, articleid);

-- работа с первичным ключом на который ничто не ссылается
alter table comments
    drop constraint comments_pkey;

alter table comments
    drop column cid;

alter table comments
    add column cid uuid default uuid_generate_v4();

alter table comments
    alter column cid set not null;

commit;