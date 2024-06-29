USER = itopchu
NAME = inception
SRCS = ./srcs
TOOLS = $(SRCS)/requirements/tools
DATA = /home/$(USER)/data

all: volume certs up

build:
    cd $(SRCS) && docker-compose build

up: build
    cd $(SRCS) && docker-compose up -d

down:
    cd $(SRCS) && docker-compose down

clean: down
    cd $(SRCS) && docker-compose rm -f
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