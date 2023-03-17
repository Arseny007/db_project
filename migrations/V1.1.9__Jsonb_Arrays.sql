begin;

alter table users
    add column job_params jsonb;

update users set job_params = (case
    when username = 'arseny' then '{"job_title":"QA Engineer",
                                    "level":"middle",
                                    "experience":4}'::jsonb
    when username = 'alla' then '{"job_title":"SRE Engineer",
                                    "level":"middle",
                                    "experience":6}'::jsonb
    when username = 'robert' then '{"job_title":"DevOps Engineer",
                                    "level":"junior",
                                    "experience":2}'::jsonb
    when username = 'ivan' then '{"job_title":"DB Administrator",
                                    "level":"senior",
                                    "experience":8}'::jsonb
    when username = 'slava' then '{"job_title":"Network engineer",
                                    "level":"senior",
                                    "experience":15}'::jsonb
    end);

alter table articles
    add column tags text[];

update articles set tags = case
    when articlename = 'как установить windows xp'
        then '{windows, xp, шиндовс, install, howto, iso, flash, bios}'::text[]
    when articlename = 'мясо ранит'
        then '{meat, harm, bio_threat, warning, vegan}'::text[]
    when articlename = 'не играйте сейчас!!'
        then '{games, harm, gameplay, leisure, entertainment}'::text[]
    when articlename = 'как подцепить девочку'
        then '{howto, girls, memes}'::text[]
    when articlename = 'используйте лицензионные программы'
        then '{pirates, crack, license, software, malware, virus}'::text[]
    when articlename = 'не совершайте моих ошибок'
        then '{life, plans, marry, mistake}'::text[]
    end;

create index users_jobs on users using gin (job_params);
create index articles_tags on articles using gin(tags);

commit;