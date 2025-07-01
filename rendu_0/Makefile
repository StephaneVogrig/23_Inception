DOCKER_COMPOSE		= docker compose -f docker-compose.yml

up:
	$(DOCKER_COMPOSE) up -d --build

down:
	$(DOCKER_COMPOSE) down

clean: down
	docker system prune -af

fclean:
	docker system prune -af --volumes
	docker volume prune -af

re: down clean up

.PHONY:	up \
		down \
		clean \
		fclean \
		re
