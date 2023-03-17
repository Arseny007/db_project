begin;

drop materialized view if exists users_with_all cascade;
DROP INDEX IF EXISTS users_search_index;

alter table comments
add column userid bigint;

alter table comments
    add column articleid bigint;

do
$$
    declare
        row record;
    begin
        for row in select * from articles2users
            loop
                update comments set userid = row.userid where comments.rid = row.rid;
                update comments set articleid = row.articleid where comments.rid = row.rid;
            end loop;
    end
$$;

select c.articleid as newArticleId, a2u.articleid as oldArticleId, c.userid as newUserId, a2u.userid as oldUserId
from comments c
    left join articles2users a2u on c.rid = a2u.rid;

alter table comments
    add constraint comments_userid_fkey foreign key (userid) references users;

alter table comments
    add constraint comments_articleid_fkey foreign key (articleid) references articles;

alter table comments
    drop constraint comments_rid_fkey;

alter table articles2users
    drop constraint articles2users_pkey;

drop materialized view if exists users_with_all cascade;

alter table articles2users
    drop column rid;

create materialized view users_with_all as
/* Запрос всего */
select uid, username, createdate, sex, A2U.articleid, aid, articlename, content, source_, publicdate, cid, commentcontent, commentpublicdate, likes, dislikes
            from Users
                left join Articles2Users A2U on Users.uid = A2U.userid
                left join Articles on A2U.articleid = Articles.aid
                left join Comments on users.uid = Comments.userid and articles.aid = comments.articleid;

commit;