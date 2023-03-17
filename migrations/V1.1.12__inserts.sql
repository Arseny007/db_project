alter table users
    add column age int;

alter table users 
    add column past_names text[];

alter table users
    add column work_experience int;

update users set age = case
    when username = 'arseny' then 19
    when username = 'alla' then 21
    when username = 'robert' then 17
    when username = 'ivan' then 26
    when username = 'slava' then 36
end;

update users set past_names = case
    when username = 'arseny' then '{"nagibator228", "krutoichel777", "arseny007"}'::text[]
    when username = 'alla' then '{"enotiks", "allmakhotka12"}'::text[]
    when username = 'robert' then '{"bob4insky", "bobchinskii"}'::text[]
    when username = 'ivan' then '{"ivanvyach", "databaser"}'::text[]
    when username = 'slava' then '{"slavik", "best_over"}'::text[]
end;

update users set work_experience = case
    when username = 'arseny' then 4
    when username = 'alla' then 6
    when username = 'robert' then 2
    when username = 'ivan' then 8
    when username = 'slava' then 15
end;