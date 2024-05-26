USER = itopchu
NAME = inception
COMPOSE_DIR = ./srcs
COMPOSE_FILE = $(COMPOSE_DIR)/docker-compose.yml
ENV_FILE = $(COMPOSE_DIR)/.env

all: volume certs up

build:
    cd srcs/ && docker-compose build

up:
    cd srcs/ && docker-compose build && docker-compose up -d

down:
    cd srcs/ && docker-compose down

clean:
    cd srcs/ && docker-compose down && docker-compose rm -f && docker volume prune -f

re: clean up

volume:
	@echo "Creating volumes " $(NAME) "."
	@mkdir -p /home/$(USER)/data/mariadb/
	@mkdir -p /home/$(USER)/data/wordpress/

certs:
	@echo "Generating certificates " $(NAME) "."
	chmod +x ./srcs/requirements/tools/certificate.sh
	./srcs/requirements/tools/certificate.sh $(USER)

.PHONY: all build up stop down clean prune remake restart logs volume certs
