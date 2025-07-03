FROM alpine:3.21

RUN apk update \
	&& apk upgrade \
	&& apk add --no-cache redis \
    && rm -rf /var/cache/apk/*

COPY redis.conf /etc/redis.conf

EXPOSE 6379

CMD ["redis-server", "/etc/redis.conf"]
