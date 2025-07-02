FROM alpine:3.21

RUN apk update \
	&& apk upgrade \
	&& apk add --no-cache \
		nginx \
    && rm -rf /var/cache/apk/*

COPY server.conf /etc/nginx/http.d
COPY G701_2025_05_02.html   /var/www/html/index.html

EXPOSE 701

CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
