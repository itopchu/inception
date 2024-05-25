USER = itopchu
NAME = inception
COMPOSE_DIR = ./srcs
ENV_FILE = $(COMPOSE_DIR)/.env

all: volume certs up

up:
	@echo "Starting " $(NAME) "."
	cd srcs && docker compose up --build

stop:
	@echo "Stopping " $(NAME) "."
	cd srcs && docker-compose stop

down:
	@echo "Stopping and removing " $(NAME) " containers and networks."
	cd srcs && docker compose down --rmi all; clear

prune: down
	@echo "Pruning unused Docker resources..."
	@docker system prune --all --force --volumes

remake: down up
	@echo "Rebuilt and restarted " $(NAME) " containers."

restart: stop up
	@echo "Restarted " $(NAME) " containers."

volume:
	@echo "Creating volumes " $(NAME) "."
	@mkdir -p /home/$(USER)/data/mariadb/
	@mkdir -p /home/$(USER)/data/wordpress/

certs:
	@echo "Generating certificates " $(NAME) "."
	chmod +x ./srcs/requirements/tools/certificate.sh
	./srcs/requirements/tools/certificate.sh $(USER)

.PHONY: all up stop down prune remake restart volume certs
