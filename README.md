# Домашние задания Борового Арсения 6.1
+ 
+ Чтобы развернуть локально используйте `docker compose up --build`
+ 
+ Запросить Comment по 3 столбцам из индекса
+ `http://127.0.0.1:36963/comment/index/commentpublicdate=2022-11-01%2008:00:49&likes=1&dislikes=3`
+ Или через curl
+ `curl 'http://127.0.0.1:36963/comment/index?commentpublicdate=2022-11-01%2008:00:49&likes=1&dislikes=3'`
+ 
+ jsonb & arrays
+ `curl --location --request POST 'http://127.0.0.1:36963/users/jobs' --header 'Content-Type: application/json' --data-raw '{"level":"middle"}'`
+ `curl --location --request POST 'http://127.0.0.1:36963/articles/tags' --header 'Content-Type: application/json' --data-raw '{"tag": "harm"}'`
+ 

# Sync ClickHouse to PGSQL
+ 
+ `curl http://127.0.0.1:34543/clickhouse/articles/index`
+
+ `curl http://127.0.0.1:34543/clickhouse/articles/diapazone`
+ 
+ 
# PGSync ES
+ по соответствию из массива
+ `curl http://localhost:34543/elastic/user_by_past_name?past_name=arseny007`
+ 
+ статистика по keyword
+ `curl http://localhost:34543/elastic/stats_by_sex`
+ 
+ поиск по синониму
+ `curl http://localhost:34543/article/synonym_search?word=meat`