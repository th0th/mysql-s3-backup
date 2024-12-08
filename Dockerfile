FROM alpine:latest

RUN apk update && \
    apk add bash curl mariadb-connector-c mysql-client pigz rclone

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]
