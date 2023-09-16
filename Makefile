DOCKER_COMPOSE_PATH	= srcs/docker-compose.yml

DB_PATH				= /home/mamaro-d/data/mariadb/

WP_PATH				= /home/mamaro-d/data/wordpress/

all:
	@ sudo chown user42 /etc/hosts
	@sudo mkdir -p $(DB_PATH) $(WP_PATH)
	@ grep -qxF '127.0.0.1 mamaro-d.42.fr' /etc/hosts || echo '127.0.0.1 mamaro-d.42.fr' >> /etc/hosts
	@ docker-compose -f $(DOCKER_COMPOSE_PATH) up --build -d

clean: stop
	@ docker system prune -a --force

fclean: clean
	@ rm -rf $(DATA_PATH)

re: fclean all


stop:
	@ docker-compose -f $(DOCKER_COMPOSE_PATH) down


.PHONY: all stop clean fclean re