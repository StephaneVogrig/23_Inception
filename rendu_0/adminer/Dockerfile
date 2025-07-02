FROM alpine:3.21

RUN apk update \
	&& apk upgrade \
	&& apk add --no-cache \
        php83 \
        php83-session \
        php83-mysqli \
        php83-pdo_mysql \
        php83-json \
        php83-mbstring \
        curl

RUN mkdir -p /var/www

RUN curl -L https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php -o /var/www/adminer.php

COPY php.ini /etc/php83/php.ini

EXPOSE 8080

CMD ["php83", "-S", "0.0.0.0:8080", "-t", "/var/www", "/var/www/adminer.php"]