USER = itopchu
NAME = inception
COMPOSE_FILE = srcs/docker-compose.yml
ENV_FILE = srcs/.env
# Build Docker containers
build:
	@mkdir -p /home/$(USER)/data/{mariadb/,wordpress/}
	chmod +x ./srcs/requirements/tools/security.sh
	chmod +x ./srcs/requirements/tools/certificate.sh
	./srcs/requirements/tools/security.sh
	./srcs/requirements/tools/certificate.sh $(USER)
	docker-compose -f $(COMPOSE_FILE) -p $(NAME) build

# Start containers
start: build
	docker-compose -f $(COMPOSE_FILE) -p $(NAME) up -d

# Stop containers
stop:
	docker-compose -f $(COMPOSE_FILE) down

# Restart containers
restart:
	@mkdir -p /home/$(USER)/data/{mariadb/,wordpress/}
	docker-compose -f $(COMPOSE_FILE) restart

# Clean previous build files
clean-build:
	docker-compose -f $(COMPOSE_FILE) down --rmi all

# Clean up containers
clean: stop
	docker system prune -a

# Remove all containers and associated volumes
purge:
	docker-compose -f $(COMPOSE_FILE) down --volumes --remove-orphans
	@rm -rf /home/$(USER)/data/

.PHONY: build start stop restart clean-build clean purge
