#!/bin/bash

# Color codes
CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Check if target_username variable is set
if [ -z "$target_username" ]; then
    echo -e "${RED}Error: target_username variable is not set.${NC}"
    exit 1
fi

# Writing to .env file
echo -e "${CYAN}Setting up .env file${NC}"
env_file="/home/$target_username/Inception/srcs/.env"

# Check if .env file exists and create if not
if [ ! -e "$env_file" ]; then
    touch "$env_file" || { echo -e "${RED}Error: Failed to create .env file.${NC}"; exit 1; }
fi

# Add or update variables in .env file
add_to_env() {
    local line="$1"
    if ! grep -qF "$line" "$env_file"; then
        echo "$line" >> "$env_file"
    fi
}

add_to_env "DOMAIN_NAME=$target_username.42.fr"
add_to_env "CERT_=./requirements/tools/$target_username.42.fr.crt"
add_to_env "KEY_=./requirements/tools/$target_username.42.fr.key"

# Ask user for DB variables
read -p "Enter the DB_NAME: " DB_NAME
read -p "Enter the DB_ROOT: " DB_ROOT
read -p "Enter the DB_USER: " DB_USER
read -p "Enter the DB_PASS: " DB_PASS

# Add DB variables to .env file
add_to_env "DB_NAME=$DB_NAME"
add_to_env "DB_ROOT=$DB_ROOT"
add_to_env "DB_USER=$DB_USER"
add_to_env "DB_PASS=$DB_PASS"

echo -e "${GREEN}Setup of .env file completed${NC}"

# Creating .dockerignore files
echo -e "${CYAN}Creating .dockerignore files${NC}"
dockerignore_dir="/home/$target_username/Inception/srcs/requirements"
echo -e ".git\n.env" > "$dockerignore_dir/mariadb/.dockerignore"
echo -e ".git\n.env" > "$dockerignore_dir/nginx/.dockerignore"
echo -e ".git\n.env" > "$dockerignore_dir/wordpress/.dockerignore"
echo -e "${GREEN}Creation of .dockerignore files completed${NC}"

# Editing Makefile
echo -e "${CYAN}Editing Makefile${NC}"
makefile="/home/$target_username/Inception/Makefile"

# Check if Makefile exists and create if not
if [ ! -e "$makefile" ]; then
    touch "$makefile" || { echo -e "${RED}Error: Failed to create Makefile.${NC}"; exit 1; }
fi

# Add Makefile commands
cat << EOL >> "$makefile"
name = inception

all:
	@docker-compose -f ./srcs/docker-compose.yml up -d

build:
	@docker-compose -f ./srcs/docker-compose.yml up -d --build

down:
	@docker-compose -f ./srcs/docker-compose.yml down

re:
	@docker-compose -f ./srcs/docker-compose.yml up -d --build

clean: down
	@printf "Cleaning configuration \${name}\n"
	@docker system prune -a

fclean:
	@docker stop $$(docker ps -qa)
	@docker system prune --all --force --volumes
	@docker network prune --force
	@docker volume prune --force

.PHONY	: all build down re clean fclean
EOL

echo -e "${GREEN}Editing of Makefile completed${NC}"
