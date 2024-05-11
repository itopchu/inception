USER = itopchu

# Build Docker containers
build:
	@mkdir -p /home/$(USER)/data/{mariadb/,wordpress/}
	./srcs/requirements/tools/security.sh
	./srcs/requirements/tools/certificate.sh $(USER)
	docker-compose -f srcs/docker-compose.yml build

# Start containers
start: build
	docker-compose -f srcs/docker-compose.yml up -d

# Stop containers
stop:
	docker-compose -f srcs/docker-compose.yml down

# Restart containers
restart:
	@mkdir -p /home/$(USER)/data/{mariadb/,wordpress/}
	docker-compose -f srcs/docker-compose.yml restart

# Clean up containers
clean: stop
	docker system prune -a

# Remove all containers and associated volumes
purge:
	docker-compose -f srcs/docker-compose.yml down --volumes --remove-orphans
	@rm -rf /home/$(USER)/data/

.PHONY: build start stop restart clean purge
