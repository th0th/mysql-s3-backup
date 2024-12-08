FROM alpine:latest

RUN apk update && \
    apk add bash curl pigz mysql-client rclone

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]
