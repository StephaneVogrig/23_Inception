# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: svogrig <svogrig@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/06/10 21:25:25 by svogrig           #+#    #+#              #
#    Updated: 2025/06/19 00:06:52 by svogrig          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

all: up

up:
	docker compose -f docker-compose.yml up -d --build

down:
	docker compose -f docker-compose.yml down

clean:
	docker system prune -af

fclean:
	docker system prune -af --volumes

re: down clean up
