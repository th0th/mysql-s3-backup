FROM alpine:latest

RUN apk update && \
    apk add bash curl mariadb-client mariadb-connector-c pigz rclone

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]
