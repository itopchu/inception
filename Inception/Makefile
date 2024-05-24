USER = itopchu
NAME = inception
COMPOSE_DIR = ./srcs
COMPOSE_FILE = $(COMPOSE_DIR)/docker-compose.yml
ENV_FILE = $(COMPOSE_DIR)/.env

all: volume security certs build up

build:
	@echo "Building " $(NAME) "."
	docker-compose -f $(COMPOSE_FILE) -p $(NAME) build

up:
	@echo "Starting " $(NAME) "."
	docker-compose -f $(COMPOSE_FILE) -p $(NAME) up -d

stop:
	@echo "Stopping " $(NAME) "."
	docker-compose -f $(COMPOSE_FILE) -p $(NAME) stop

down:
	@echo "Stopping and removing " $(NAME) " containers and networks."
	docker-compose -f $(COMPOSE_FILE) -p $(NAME) down

clean:
	@echo "Stopping and removing " $(NAME) " containers, networks, images, and volumes."
	docker-compose -f $(COMPOSE_FILE) -p $(NAME) down --volumes --remove-orphans

prune: clean
	@echo "Pruning unused Docker resources..."
	@docker system prune --all --force --volumes

remake: clean build up
	@echo "Rebuilt and restarted " $(NAME) " containers."

restart: stop up
	@echo "Restarted " $(NAME) " containers."

logs:
	docker-compose -f $(COMPOSE_FILE) logs -f

volume:
	@echo "Creating volumes " $(NAME) "."
	@mkdir -p /home/$(USER)/data/{mariadb/,wordpress/}

security:
	@echo "Receiving security keys " $(NAME) "."
	chmod +x ./srcs/requirements/tools/security.sh
	./srcs/requirements/tools/security.sh $(USER)

certs:
	@echo "Generating certificates " $(NAME) "."
	chmod +x ./srcs/requirements/tools/certificate.sh
	./srcs/requirements/tools/certificate.sh $(USER)

.PHONY: all build up stop down clean prune remake restart logs volume security certs
