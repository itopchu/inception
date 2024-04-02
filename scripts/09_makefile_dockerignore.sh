#!/bin/bash

# Color codes
CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Writing to .env file
echo -e "${CYAN}Setting up .env file${NC}"
echo "DOMAIN_NAME=$target_username.42.fr" > /home/$target_username/Inception/srcs/.env
echo "CERT_=./requirements/tools/$target_username.42.fr.crt" >> /home/$target_username/Inception/srcs/.env
echo "KEY_=./requirements/tools/$target_username.42.fr.key" >> /home/$target_username/Inception/srcs/.env
echo "DB_NAME=wordpress" >> /home/$target_username/Inception/srcs/.env
echo "DB_ROOT=rootpass" >> /home/$target_username/Inception/srcs/.env
echo "DB_USER=wpuser" >> /home/$target_username/Inception/srcs/.env
echo "DB_PASS=wppass" >> /home/$target_username/Inception/srcs/.env
echo -e "${GREEN}Setup of .env file completed${NC}"

# Creating .dockerignore files
echo -e "${CYAN}Creating .dockerignore files${NC}"
echo -e ".git\n.env" > /home/$target_username/Inception/srcs/requirements/mariadb/.dockerignore
echo -e ".git\n.env" > /home/$target_username/Inception/srcs/requirements/nginx/.dockerignore
echo -e ".git\n.env" > /home/$target_username/Inception/srcs/requirements/wordpress/.dockerignore
echo -e "${GREEN}Creation of .dockerignore files completed${NC}"

# Editing Makefile
echo -e "${CYAN}Editing Makefile${NC}"
cat << EOL >> /home/$target_username/Inception/Makefile
name = inception

all:
	@printf "Launching configuration \${name}\n"
	@docker-compose -f ./srcs/docker-compose.yml up -d

build:
	@printf "Building configuration \${name}\n"
	@docker-compose -f ./srcs/docker-compose.yml up -d --build

down:
	@printf "Stopping configuration \${name}\n"
	@docker-compose -f ./srcs/docker-compose.yml down

re:
	@printf "Rebuilding configuration \${name}\n"
	@docker-compose -f ./srcs/docker-compose.yml up -d --build

clean: down
	@printf "Cleaning configuration \${name}\n"
	@docker system prune -a

fclean:
	@printf "Total clean of all configurations docker\n"
	@docker stop $$(docker ps -qa)
	@docker system prune --all --force --volumes
	@docker network prune --force
	@docker volume prune --force

.PHONY	: all build down re clean fclean
EOL

echo -e "${GREEN}Editing of Makefile completed${NC}"
