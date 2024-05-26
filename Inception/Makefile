USER = itopchu
NAME = inception

all: volume certs up

build:
	cd srcs && docker-compose build

up: build
	cd srcs && docker-compose up -d

down:
	cd srcs && docker-compose down

clean: down
	cd srcs && docker-compose rm -f
	docker volume prune -f

re: clean up

volume:
	@echo "Creating volumes $(NAME)."
	@mkdir -p /home/$(USER)/data/mariadb/
	@mkdir -p /home/$(USER)/data/wordpress/

certs:
	@echo "Generating certificates $(NAME)."
	chmod +x ./srcs/requirements/tools/certificate.sh
	./srcs/requirements/tools/certificate.sh $(USER)

.PHONY: all build up down clean re volume certs
