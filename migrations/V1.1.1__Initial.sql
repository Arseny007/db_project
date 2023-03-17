create table if not exists Articles(
    aid bigint not null primary key generated always as identity,
    articlename text unique,
    content text unique,
    source_ text,
    publicdate text
);

create table if not exists Users(
    uid bigint not null primary key generated always as identity,
    username text unique,
    createdate text,
    sex text
);

create table if not exists Articles2Users (
    rid bigint not null primary key generated always as identity,
    userid bigint not null references Users,
    articleid bigint not null references Articles,
    mark text,
    unique (userid, articleid)
);

create table if not exists Comments(
    cid bigint not null primary key generated always as identity,
    rid bigint not null references Articles2Users,
    commentcontent text,
    commentpublicdate text,
    likes int,
    dislikes int
);

insert into Users (username, createdate, sex)
values  ('arseny', '2022-05-14 13:13:13', 'male'),
        ('alla', '2022-06-05 23:50:41', 'female'),
        ('robert', '2022-06-01 07:40:59', 'male'),
        ('ivan', '2022-03-15 14:12:30', 'male'),
        ('slava', '2022-04-29 17:03:09', 'male');

insert into Articles (articlename, content, publicdate)
values ('как установить windows xp', 'Сначала вы должны заиметь образ Windows на флешке с uefi разметкой', '2022-10-01 10:00:01'),
       ('мясо ранит', 'Мясо убивает! Хватит есть мясо!', '2022-10-01 10:00:01'),
       ('не играйте сейчас!', 'ЕСЛИ ВЫ ИГРАЕТЕ, ТО УБИВАЕТЕ МИЛЛИОНЫ ПЕРСОНАЖЕЙ В ГОД', '2022-10-01 10:00:01'),
       ('как подцепить девочку', 'Подойдите к ней и скажите ФФФУУУУУУУУУУУУ', '2022-10-01 10:00:01'),
       ('используйте лицензионные программы', 'Все пираты должны умереть!', '2022-10-01 10:00:01'),
       ('не совершайте моих ошибок', 'я женился', '2022-10-01 10:00:01');

insert into Articles2Users (userid, articleid, mark)
values (1, 1, Null), (1, 2, 'dislike'), (1, 3, Null),
        (1, 4, Null), (1, 6, 'like'), (2, 2, Null),
        (2, 3, 'like'), (2, 4, Null), (2, 5, 'like'),
        (2, 6, Null), (3, 1, Null), (3, 2, 'dislike'),
        (3, 4, Null), (3, 5, Null), (3, 6, Null),
        (4, 1, 'like'), (4, 2, Null), (4, 3, 'dislike'),
        (4, 5, Null), (4, 6, Null), (5, 1, 'dislike'),
        (5, 2, 'like'), (5, 3, 'like'), (5, 4, Null),
        (5, 5, 'dislike');

insert into Comments (rid, commentcontent, commentpublicdate, likes, dislikes)
    values  (20, 'Hi, its my first comment', '2022-11-01 08:00:49', 1, 3),
            (2, 'im agree', '2022-11-05 07:37:09', 500, 300),
            (4, 'author is condom', '2022-10-04 23:48:12', 50, 20),
            (6, 'Читаю unix', '2022-09-13 09:53:01', 24, 30),
            (7, 'Отключилась от интернета полностью', '2022-12-24 15:24:01', 35, 7),
            (9, 'Хз как получится короче', '2022-11-16 15:07:54', 100, 0),
            (12, 'aboba', '2022-09-04 04:30:20', 53, 304),
            (14, 'abiba', '2022-11-30 07:29:05', 25, 29),
            (15, 'spasiba', '2022-10-20 19:35:41', 14, 12),
            (17, 'not working', '2022-08-14 20:13:27', 2, 4),
            (23, 'promise', '2022-11-23 22:04:40', 1, 4);
