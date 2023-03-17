from typing import OrderedDict

class User:
    def __init__(self, username: str, createdate: str, sex: str):
        self.username = username
        self.createdate = createdate
        self.sex = sex
        self.articles: list[Article] = []
        self.comments: list[Comment] = []

class Article:
    def __init__(self, articlename: str, content: str, source_: str, publicdate: str):
        self.articlename = articlename
        self.content = content
        self.source_ = source_
        self.publicdate = publicdate

class Comment:
    def __init__(self, cid: int, userid: int, articleid: int, commentcontent: str, commentpublicdate: str, likes: int, dislikes:int):
        self.cid = cid
        self.userid = userid
        self.articleid = articleid
        self.commentcontent = commentcontent
        self.commentpublicdate = commentpublicdate
        self.likes = likes
        self.dislikes = dislikes

def deserialize_users(rows: list[OrderedDict]):
    users_dict = {}
    articles_dict = {}
    comments_dict = {}
    for row in rows:
        username = row['username']
        createdate = row['createdate']
        sex = row['sex']

        user = None
        if username in users_dict:
            user = users_dict[username]
        else:
            user = User(username, createdate, sex)
            users_dict[username] = user

        articlename = row['articlename']
        content = row['content']
        source_ = row['source_']
        publicdate = row['publicdate']

        article = None
        if articlename in articles_dict:
            article = articles_dict[articlename]
        elif articlename is not None:
            article = Article(articlename, content, source_, publicdate)
            articles_dict[articlename] = article

        comment = None
        cid = row['cid']
        articleid = row['aid']
        userid = row['uid']
        commentcontent = row['commentcontent']
        commentpublicdate = row['commentpublicdate']
        likes = row['likes']
        dislikes = row['dislikes']
        if cid in comments_dict:
            comment = comments_dict[cid]
        elif cid is not None:
            comment = Comment(cid, articleid, userid, commentcontent, commentpublicdate, likes, dislikes)
            comments_dict[cid] = comment

        if articlename is not None:
            if article not in user.articles: user.articles.append(article)

        if cid is not None:
            if comment not in user.comments: user.comments.append(comment)

    return list(users_dict.values())

