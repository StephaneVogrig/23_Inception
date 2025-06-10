# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: svogrig <svogrig@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/06/10 21:25:57 by svogrig           #+#    #+#              #
#    Updated: 2025/06/10 21:41:33 by svogrig          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


FROM debian:bullseye

# install nginx
RUN apt update -y \
	&& apt upgrade -y \
	&& apt install -y nginx

# # setup nginx
# RUN 

# install ssl
RUN apt update -y \
	&& apt upgrade -y \
	&& apt install -y openssl

# setup ssl
RUN mkdir -p /etc/nginx/ssl/
RUN openssl req \
	-x509 \
	-nodes \
	-out /etc/nginx/ssl/inception.crt \
	-keyout /etc/nginx/ssl/inception.key \
	-subj "/C=FR/ST=NA/L=Angouleme/O=42/OU=42/CN=svogrig.42.fr/UID=svogrig"

EXPOSE 80/tcp

CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
