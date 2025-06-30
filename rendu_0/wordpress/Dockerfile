# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: svogrig <svogrig@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/06/19 03:43:34 by svogrig           #+#    #+#              #
#    Updated: 2025/06/30 19:58:09 by svogrig          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.21

ENV PHP_VERSION=83
RUN apk add --no-cache \
    php${PHP_VERSION} \
    php${PHP_VERSION}-fpm \
    php${PHP_VERSION}-mysqli \
    php${PHP_VERSION}-json \
    php${PHP_VERSION}-openssl \
    php${PHP_VERSION}-curl \
    php${PHP_VERSION}-zlib \
    php${PHP_VERSION}-xml \
    php${PHP_VERSION}-phar \
    php${PHP_VERSION}-intl \
    php${PHP_VERSION}-dom \
    php${PHP_VERSION}-xmlreader \
    php${PHP_VERSION}-ctype \
    php${PHP_VERSION}-session \
    php${PHP_VERSION}-mbstring \
    php${PHP_VERSION}-gd \
    php${PHP_VERSION}-zip \
    php${PHP_VERSION}-exif \
    php${PHP_VERSION}-fileinfo \
    php${PHP_VERSION}-tokenizer \
    php${PHP_VERSION}-simplexml \
	curl \
	mariadb-client \
    && rm -rf /var/cache/apk/*

WORKDIR /var/www/html

# Install wp-cli 
RUN curl -o /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
     && chmod +x /usr/local/bin/wp

RUN curl -O https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz --strip-components=1 && \
    rm latest.tar.gz

COPY entrypoint.sh /scripts/entrypoint.sh
RUN chmod +x /scripts/entrypoint.sh

EXPOSE 9000

ENTRYPOINT ["/scripts/entrypoint.sh"]
