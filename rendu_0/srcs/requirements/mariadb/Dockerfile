# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: svogrig <svogrig@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/06/16 21:54:01 by svogrig           #+#    #+#              #
#    Updated: 2025/06/16 21:56:02 by svogrig          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.21.0

# install nginx
RUN apk update \
	&& apk upgrade \
	&& apk add nginx openssl
copy conf/inception.conf /etc/nginx/http.d

# install ssl
RUN apk update \                                                                           
    && apk add mariadb mariadb-client pwgen \
    && apk add --update tzdata \
    && cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime \
    && echo "${TIMEZONE}" > /etc/timezone \
    && chmod a+x /usr/local/bin/launch-db

EXPOSE 3306/tcp

CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
