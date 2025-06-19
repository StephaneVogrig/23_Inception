# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: svogrig <svogrig@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/06/16 21:54:01 by svogrig           #+#    #+#              #
#    Updated: 2025/06/19 02:54:56 by svogrig          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.21

RUN apk add --no-cache mariadb mariadb-client

COPY entrypoint.sh /scripts/entrypoint.sh
RUN chmod +x /scripts/entrypoint.sh

EXPOSE 3306/tcp

ENTRYPOINT ["/scripts/entrypoint.sh"]
