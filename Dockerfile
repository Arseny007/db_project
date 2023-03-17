FROM python:3.9.13

WORKDIR /flask_app

RUN apt-get update && apt-get install -y libpq-dev python-dev gcc

COPY requirements.txt .
RUN pip3 install -r requirements.txt

COPY main.py .
COPY deserialization.py .
# COPY migrations/ ./migrations/
COPY static/ ./static/

ENV FLASK_APP main.py