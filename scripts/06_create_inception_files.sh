#!/bin/bash

# Color codes
CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${CYAN}06_create_inception_files.sh started${NC}"

# Create Inception directories and files
mkdir -p /home/$target_username/Inception/srcs/requirements/{wordpress/{conf,tools},nginx/{conf,tools},mariadb/{conf,tools},bonus,tools}
touch /home/$target_username/Inception/{Makefile,srcs/{.env,docker-compose.yml}}
touch /home/$target_username/Inception/srcs/requirements/{wordpress/{Dockerfile,.dockerignore},nginx/{Dockerfile,.dockerignore},mariadb/{Dockerfile,.dockerignore},bonus,tools}

# Check if the commands were successful
if [ $? -eq 0 ]; then
    echo -e "${GREEN}06_create_inception_files.sh ended${NC}"
else
    echo -e "${RED}06_create_inception_files.sh failed. Script terminating.${NC}"
    exit 1
fi
