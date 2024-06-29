USER = itopchu
NAME = inception
SRCS = ./srcs
TOOLS = $(SRCS)/requirements/tools
DATA = /home/$(USER)/data

all: volume certs envs up

build:
	docker-compose --env-file $(SRCS)/.env -f $(SRCS)/docker-compose.yml build

up: build
	docker-compose --env-file $(SRCS)/.env -f $(SRCS)/docker-compose.yml up -d

down:
	@docker-compose -f ./srcs/docker-compose.yml down

clean fclean: down
	@docker stop $$(docker ps -qa) > /dev/null 2>&1; \
	docker rm $$(docker ps -qa) > /dev/null 2>&1; \
	docker rmi -f $$(docker images -qa) > /dev/null 2>&1; \
	docker volume rm $$(docker volume ls -q) > /dev/null 2>&1; \
	docker network rm $$(docker network ls -q) > /dev/null 2>&1; \
	sudo rm -rf $(DATA)/wordpress; \
	sudo rm -rf $(DATA)/mariadb; \

re: clean up

volume:
	@echo "Creating volumes $(NAME)."
	@mkdir -p $(DATA)/mariadb/
	@mkdir -p $(DATA)/wordpress/

certs:
	@echo "Generating certificates $(NAME)."
	chmod +x $(TOOLS)/certificate.sh
	$(TOOLS)/certificate.sh $(USER)

envs:
	@export USER_NAME=$(USER) DOMAIN_NAME=$(USER).42.fr WP_PATH="/var/www/html"

.PHONY: all build up down clean re volume certs