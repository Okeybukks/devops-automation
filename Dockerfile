# pull the python image as our base image
FROM python:3.10-alpine
ENV PYTHONUNBUFFERED 1

LABEL maintainer="achebepeter94@gmail.com"

RUN pip install --upgrade pip
RUN apk add --update --no-cache postgresql-client jpeg-dev
RUN apk add --update --no-cache --virtual .tmp-build-deps \
      gcc libc-dev linux-headers postgresql-dev musl-dev zlib zlib-dev

RUN apk del .tmp-build-deps

COPY ./app /app

COPY ./scripts /scripts

RUN chmod +x /scripts/*

# set the working directory to the project directory
WORKDIR /app

# install the project dependencies
RUN pip install -r requirements.txt

# expose the port 8000
EXPOSE 8000

ENTRYPOINT [ "/scripts/entrypoint.sh"]