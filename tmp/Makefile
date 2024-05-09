NAME =
USER = $target_username

all:
	@bash -c "mkdir -p /home/$(USER)/data/{wordpress/,mariadb/}"
	@docker-compose -f ./srcs/docker-compose.yml --env-file ./srcs/.env up -d

build:
	@bash -c "mkdir -p /home/$(USER)/data/{wordpress/,mariadb/}"
	@docker-compose -f ./srcs/docker-compose.yml --env-file ./srcs/.env up -d --build

down:
	@docker-compose -f ./srcs/docker-compose.yml down

re: down fclean build all
	@docker-compose -f ./srcs/docker-compose.yml up -d --build

clean: down
	@docker system prune -a
	@bash -c "rm -rf /home/$(USER)/data"

fclean:
	@printf "Total clean of all configurations docker\n"
	@bash -c "rm -rf /home/$(USER)/data"
	@docker stop $$(docker ps -qa)
	@docker system prune --all --force --volumes
	@docker network prune --force
	@docker volume prune --force

.PHONY	: all build down re clean fclean