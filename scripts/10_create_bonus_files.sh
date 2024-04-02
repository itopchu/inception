#!/bin/bash

# Color codes
CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${CYAN}10_create_bonus_files.sh started${NC}"

# Create Bonus directories and files
mkdir -p /home/$target_username/Inception/srcs/requirements/bonus/{adminer/{conf,tools},redis/{conf,tools},ftp-server/{conf,tools}}
touch /home/$target_username/Inception/srcs/requirements/bonus/{adminer/{Dockerfile,.dockerignore},redis/{Dockerfile,.dockerignore},ftp-server/{Dockerfile,.dockerignore}}

# Check if the commands were successful
if [ $? -eq 0 ]; then
    echo -e "${GREEN}10_create_bonus_files.sh ended${NC}"
else
    echo -e "${RED}10_create_bonus_files.sh failed. Script terminating.${NC}"
    exit 1
fi

mkdir -p ./Inception/srcs/requirements/bonus/{adminer/{conf,tools},redis/{conf,tools},ftp-server/{conf,tools}}
touch ./Inception/srcs/requirements/bonus/{adminer/{Dockerfile,.dockerignore},redis/{Dockerfile,.dockerignore},ftp-server/{Dockerfile,.dockerignore}}
