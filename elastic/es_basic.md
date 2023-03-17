# Создание индекса
```
PUT http://localhost:41554/users
```
```json
{
    "settings": {
        "index": {
            "number_of_shards": 1,
            "number_of_replicas": 0
        }
    },
    "mappings": {
        "properties": {
            "username": {
                "type": "keyword"
            },
            "createdate": {
                "type": "keyword"
            },
            "sex": {
                "type": "keyword"
            },
            "job_params": {
                "type": "nested",
                "properties": {
                    "job_title": {
                    "type": "keyword"
                    },
                    "level": {
                    "type": "keyword"
                    },
                    "experience": {
                    "type": "long"
                    }
                }
            }
        }
    }
}
```
# Вставка данных
```
POST localhost:41554/_bulk
```
```json
{"index":{"_index":"users","_id":"arseny"}}
{"username":"arseny","createdate":"2022-05-14 13:13:13","sex":"male","job_params":{"job_title":"QA Engineer","level":"middle","experience":4}}
{"index":{"_index":"users","_id":"alla"}}
{"username":"alla","createdate":"2022-06-05 23:50:41","sex":"female","job_params":{"job_title":"SRE Engineer","level":"middle","experience":6}}
{"index":{"_index":"users","_id":"robert"}}
{"username":"robert","createdate":"2022-06-01 07:40:59","sex":"male","job_params":{"job_title":"DevOps Engineer","level":"junior","experience":2}}
{"index":{"_index":"users","_id":"ivan"}}
{"username":"ivan","createdate":"2022-03-15 14:12:30","sex":"male","job_params":{"job_title":"DB Administrator","level":"senior","experience":8}}
{"index":{"_index":"users","_id":"slava"}}
{"username":"slava","createdate":"2022-04-29 17:03:09","sex":"male","job_params":{"job_title":"Network engineer","level":"senior","experience":15}}
```
# Получение документа
```
GET http://localhost:41554/users/_doc/arseny
```
# Обновление документа
```
POST http://localhost:41554/users/_update/arseny
```
```json
{
    "doc": {
        "job_params": {
            "job_title":"QA Engineer",
            "level":"middle",
            "experience": 5
        } 
    }
}
```
# Удаление документа
```
DELETE http://localhost:41554/users/_doc/arseny
```
# Удаление индекса
```
DELETE http://localhost:41554/users
```