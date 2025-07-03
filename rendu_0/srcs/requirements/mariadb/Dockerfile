FROM alpine:3.21

RUN apk update \
	&& apk upgrade \
	&& apk add --no-cache \
        mariadb \
        mariadb-client \
    && rm -rf /var/cache/apk/*

COPY entrypoint.sh /scripts/entrypoint.sh
RUN chmod +x /scripts/entrypoint.sh

EXPOSE 3306

ENTRYPOINT ["/scripts/entrypoint.sh"]
