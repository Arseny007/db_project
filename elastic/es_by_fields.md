# Все запросы по пути 
``` GET localhost:41554/users/_search ```
# must
```json
{
    "query": {
        "bool": {
            "must": [
                {
                    "nested": {
                        "path": "job_params",
                        "query": {
                            "term": {
                                "job_params.level": "senior"
                            }
                        }
                    }
                },
                {
                    "range": {
                        "age": {
                            "gt": 24
                        }
                    }
                }
            ]
        }
    }
}

```
# must_not
```json
{
    "query": {
        "bool": {
            "must_not": [
                {
                    "range": {
                        "age": {
                            "gt": 24
                        }
                    }
                }
            ]
         }
    }
}
```
# should
```json
{
    "query": {
        "bool": {
            "should": [
                {
                    "nested": {
                        "path": "job_params",
                        "query": {
                            "term": {
                                "job_params.level": "senior"
                            }
                        }
                    }
                },
                {
                    "nested": {
                        "path": "job_params",
                        "query": {
                            "range": {
                                "job_params.experience": {
                                    "gte": 6
                                }
                            }
                        }
                    }
                }
            ],
            "minimum_should_match": 1
        }
    }
}

```
# соответствию
```json
{
    "query": {
        "term": {
            "createdate": "2022-06-01 07:40:59"
        }
    }
}

```
# содержанию в массиве примитивных типов
```json
{
    "query": {
        "term": {
            "past_names": "bob4insky"
        }
    }
}

```
# содержанию в массиве объектов
```json
{
    "query": {
        "nested": {
            "path": "job_params",
            "query": {
                "term": {
                    "job_params.level": "senior"
                }
            }
        }
    }
}
```
# диапазону
```json
{
    "query": {
        "nested": {
            "path": "job_params",
            "query": {
                "range": {
                    "job_params.experience": {
                        "gte": 3,
                        "lte": 10
                    }
                }
            }
        }
    }
}
```
# выражению
```json
{
    "query": {
        "script": {
            "script": "doc['age'].value - doc['work_experience'].value < 20"
        }
    }
}

```
# существованию свойства
```json
{
    "query": {
        "exists": {
            "field": "age"
        }

    }
}
```