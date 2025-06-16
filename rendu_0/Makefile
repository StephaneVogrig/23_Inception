# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: svogrig <svogrig@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/06/10 21:25:25 by svogrig           #+#    #+#              #
#    Updated: 2025/06/10 21:46:09 by svogrig          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

all: up

up:
	docker compose -f ./srcs/docker-compose.yml up -d --build

down:
	docker compose -f ./srcs/docker-compose.yml down

clean:
	docker system prune -af

fclean:
	docker system prune -af --volumes

re: down fclean up
