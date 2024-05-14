USER = itopchu
NAME = inception
COMPOSE_FILE = srcs/docker-compose.yml
# Start containers
start: build
	docker-compose -f $(COMPOSE_FILE) -p $(NAME) up -d

# Build Docker containers
build:
	@mkdir -p /home/$(USER)/data/{mariadb/,wordpress/}
	chmod +x ./srcs/requirements/tools/security.sh
	chmod +x ./srcs/requirements/tools/certificate.sh
	./srcs/requirements/tools/security.sh
	./srcs/requirements/tools/certificate.sh $(USER)
	docker-compose -f $(COMPOSE_FILE) -p $(NAME) build

# Stop containers
stop:
	@ docker-compose -f $(COMPOSE_FILE) down

# Clean up containers
clean: stop
	@ rm -rf /home/$(USER)/data/

# Remove all containers and associated volumes
purge: clean
	docker system prune -f

# Restart containers
restart:
	@mkdir -p /home/$(USER)/data/{mariadb/,wordpress/}
	docker-compose -f $(COMPOSE_FILE) up --build

.PHONY: build start stop restart clean-build clean purge
