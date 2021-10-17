FROM python:3.9-alpine
LABEL maintainer="Informach"

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# install requirements
RUN mkdir -p /opt/requirements
ADD app/requirements /opt/requirements
RUN apk add --update --no-cache postgresql-client jpeg-dev
RUN apk add --update --no-cache --virtual .tmp-build-deps \
    build-base gcc libc-dev linux-headers postgresql-dev musl-dev zlib zlib-dev
RUN pip install --upgrade pip
RUN pip install -r /opt/requirements/development.txt
RUN apk del .tmp-build-deps

# install dockerize
RUN apk add --no-cache openssl
ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz

# install git and bash
RUN apk add bash
RUN apk add git

# create and set the work dir
RUN mkdir /app
WORKDIR /app

# add app
COPY ./app .

# install pre commit
RUN git init
RUN pre-commit install -t pre-commit
RUN pre-commit install -t pre-push

# create and set a user
RUN adduser --disabled-password --uid 1000 python
RUN mkdir /home/python/.ssh
USER python
