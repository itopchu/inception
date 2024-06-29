USER = itopchu
NAME = inception
SRCS = ./srcs
TOOLS = $(SRCS)/requirements/tools
DATA = /home/$(USER)/data

all: volume certs up

build:
    docker-compose -f $(SRCS)/docker-compose.yml build

up: build
    docker-compose -f $(SRCS)/docker-compose.yml up -d

down:
    docker-compose -f $(SRCS)/docker-compose.yml down

clean: down
    docker-compose -f $(SRCS)/docker-compose.yml rm -f
    docker volume prune -f

re: clean up

volume:
    @echo "Creating volumes $(NAME)."
    @mkdir -p $(DATA)/mariadb/
    @mkdir -p $(DATA)/wordpress/

certs:
    @echo "Generating certificates $(NAME)."
    chmod +x $(TOOLS)/certificate.sh
    $(TOOLS)/certificate.sh $(USER)

.PHONY: all build up down clean re volume certs