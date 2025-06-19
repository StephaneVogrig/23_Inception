# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: svogrig <svogrig@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/06/10 21:25:25 by svogrig           #+#    #+#              #
#    Updated: 2025/06/19 20:11:42 by svogrig          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

DOCKER_COMPOSE		= docker compose -f docker-compose.yml
DATA_DIR_MARIADB	= /home/svogrig/data/mariadb
DATA_DIR_WORDPRESS	= /home/svogrig/data/wordpress

up:
	mkdir -p $(DATA_DIR_MARIADB)
	mkdir -p $(DATA_DIR_WORDPRESS)
	$(DOCKER_COMPOSE) up -d --build

down:
	$(DOCKER_COMPOSE) down

clean: down
	docker system prune -af

fclean:
	docker system prune -af --volumes
	rm -rf $(DATA_DIR_MARIADB)
	rm -rf $(DATA_DIR_WORDPRESS)

re: down clean up

.PHONY:	up \
		down \
		clean \
		fclean \
		re
