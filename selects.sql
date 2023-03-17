select uid, username, createdate, sex, job_params, aid, articlename, content, source_, publicdate, tags, cid, commentcontent, commentpublicdate, likes, dislikes
        from Users
            left join Articles2Users A2U on Users.uid = A2U.userid
            left join Articles on A2U.articleid = Articles.aid
            left join Comments C on A2U.articleid = C.articleid and A2U.userid = C.userid;

select username, sex, job_params
from users;