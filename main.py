from unittest import result
from flask import Flask, jsonify, request, send_file
import psycopg2
from redis import Redis
import json
import os
from psycopg2.extras import RealDictCursor, Json
import logging
import clickhouse_connect
from elasticsearch import Elasticsearch

app = Flask(__name__)
app.config['JSON_AS_ASCII'] = False

# pg_conn = psycopg2.connect(database='test_db', user='postgres', password='postgres', host='localhost', port=38746,
# #                            cursor_factory=RealDictCursor)
# pg_conn.autocommit = True

from deserialization import deserialize_users

# redis_conn = Redis(port=26596, password='redis', decode_responses=True)

def get_pg_connection():
    pg_conn = psycopg2.connect(host=os.getenv('POSTGRES_HOST') or '127.0.0.1', 
                                port=os.getenv('POSTGRES_PORT'),
                                database=os.getenv('POSTGRES_DB'), 
                                user=os.getenv('POSTGRES_USER'),
                                password=os.getenv('POSTGRES_PASSWORD'), 
                                cursor_factory=RealDictCursor)
    pg_conn.autocommit = True
    return pg_conn

def get_pg_connection_replica():
    pg_conn = psycopg2.connect(host=os.getenv('POSTGRES_HOST') or '127.0.0.1', 
                                port=os.getenv('SLAVE_PORT'),
                                database=os.getenv('POSTGRES_DB'), 
                                user=os.getenv('POSTGRES_USER'),
                                password=os.getenv('POSTGRES_PASSWORD'), 
                                cursor_factory=RealDictCursor)
    pg_conn.autocommit = True
    return pg_conn

def get_redis_connection():
    return Redis(host=os.getenv('REDIS_HOST') or '127.0.0.1', port=os.getenv('REDIS_PORT'),
                 password=os.getenv('REDIS_PASSWORD'), decode_responses=True)

def get_clickhouse_connection():
    host = os.getenv('CLICKHOUSE_HOST') or '127.0.0.1'
    port = os.getenv('CLICKHOUSE_PORT')
    user = os.getenv('CLICKHOUSE_USER')
    password = os.getenv('CLICKHOUSE_PASSWORD')
    return clickhouse_connect.get_client(host=host, username=user, password=password, port=port, database='postgres_repl')

def get_elastic_connection():
    host = os.getenv('ELASTIC_HOST') or '127.0.0.1'
    port = os.getenv('ELASTIC_PORT')
    return Elasticsearch(hosts=f'http://{host}:{port}')


@app.route('/elastic/city')
def users_match_search():
    try:
        query = {
            "match": {
            "arrival": {
                "query": "Красно",
                "analyzer": "ngram_ru_analyzer"
                }
            }
        }
        with get_elastic_connection() as es:
            es_resp = es.search(index='tickets', query=query)
        citys = ""
        for hit in es_resp['hits']['hits']:
            city = hit['_source']['arrival']
            citys += city + ' '
        
        if citys != 0:
            return citys
        else:
            return {'message': 'Not Found'}, 404
    except Exception as ex:
        logging.error(repr(ex), exc_info=True)
        return {'message': 'Bad Request'}, 400