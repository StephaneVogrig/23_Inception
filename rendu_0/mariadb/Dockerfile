FROM alpine:3.21

RUN apk add --no-cache mariadb mariadb-client

COPY entrypoint.sh /scripts/entrypoint.sh
RUN chmod +x /scripts/entrypoint.sh

EXPOSE 3306/tcp

ENTRYPOINT ["/scripts/entrypoint.sh"]
