# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: svogrig <svogrig@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/06/16 21:54:01 by svogrig           #+#    #+#              #
#    Updated: 2025/06/17 16:18:36 by svogrig          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

# install mariadb
RUN apt update -y && apt upgrade -y && apt-get install mariadb-server -y

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY tools/run.sh /scripts/run.sh
RUN chmod -R 755 /scripts

EXPOSE 3306/tcp

ENTRYPOINT ["/scripts/run.sh"]
