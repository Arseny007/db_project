drop materialized view if exists users_with_all;
create materialized view users_with_all as
/* Запрос всего */
select uid, username, createdate, sex, aid, articlename, content, source_, publicdate, cid, commentcontent, commentpublicdate, likes, dislikes
        from Users
            left join Articles2Users A2U on Users.uid = A2U.userid
            left join Articles on A2U.articleid = Articles.aid
            left join Comments C on A2U.articleid = C.articleid and A2U.userid = C.userid;