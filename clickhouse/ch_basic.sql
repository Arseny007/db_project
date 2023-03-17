drop table if exists users;

create table users
(
    username text,
    createdate text,
    sex text,
    "job_params.job_title" Array(text),
    "job_params.level" Array(text),
    "job_params.experience" Array(int)
) engine = ReplacingMergeTree() order by (username);

-- insert

insert into users
values ('arseny', '2022-05-14 13:13:13', 'male', ['QA Engineer'], ['middle'], [4]),
        ('alla', '2022-06-05 23:50:41', 'female', ['SRE Engineer'], ['middle'], [6]),
        ('robert', '2022-06-01 07:40:59', 'male', ['DevOps Engineer'], ['junior'], [2]),
        ('ivan', '2022-03-15 14:12:30', 'male', ['DB Administrator'], ['senior'], [8]),
        ('slava', '2022-04-29 17:03:09', 'male', [], [], []);

-- nested-objects-search

select * 
from users
where has(job_params.level, 'middle');

-- nested-objects-aggregation

select min("job_params.experience")
from users 
    array join "job_params.experience";

-- update-data

insert into users
values ('slava', '2022-04-29 17:03:09', 'male', ['Network engineer'], ['senior'], [15]);

select * from users final;