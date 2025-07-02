FROM alpine:3.21
# FROM debian:11

RUN apk update && apk upgrade \
    && apk add --no-cache \
        php83 \
        php83-fpm \
        php83-mysqli \
        php83-json \
        php83-openssl \
        php83-curl \
        php83-zlib \
        php83-xml \
        php83-phar \
        php83-intl \
        php83-dom \
        php83-xmlreader \
        php83-ctype \
        php83-session \
        php83-mbstring \
        php83-gd \
        php83-zip \
        php83-exif \
        php83-fileinfo \
        php83-tokenizer \
        php83-simplexml \
        curl \
	    mariadb-client \
    && rm -rf /var/cache/apk/*
# RUN apt-get update -y && apt-get upgrade -y \
#     && apt-get install -y \
#     php php-fpm php-mysql curl \
#     && rm -rf /var/lib/apt/lists/*

# Install wp-cli (needed by script entrypoint)
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

COPY ./php.ini /etc/php83/php.ini
COPY ./www.conf /etc/php83/php-fpm.d/

RUN mkdir -p /run/php

COPY entrypoint.sh /scripts/entrypoint.sh
RUN chmod +x /scripts/entrypoint.sh

WORKDIR /var/www/html
# WORKDIR	/var/www/wordpress/

EXPOSE 9000

ENTRYPOINT ["/scripts/entrypoint.sh"]
