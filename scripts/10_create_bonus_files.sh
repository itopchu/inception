#!/bin/bash

# Color codes
CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${CYAN}10_create_bonus_files.sh started${NC}"

# Checkpoint to ask the user if they want to create bonus files
read -p "Do you want to create bonus files? (y/n): " create_bonus

if [ "$create_bonus" != "y" ] && [ "$create_bonus" != "Y" ]; then
    echo -e "${CYAN}Skipping creation of bonus files.${NC}"
    exit 0
fi

# Define base directory
base_dir="/home/$target_username/Inception/srcs/requirements/bonus"

# Create Bonus directories and files
mkdir -p "$base_dir/adminer/{conf,tools}"
mkdir -p "$base_dir/redis/{conf,tools}"
mkdir -p "$base_dir/ftp-server/{conf,tools}"

touch "$base_dir/adminer/Dockerfile" "$base_dir/adminer/.dockerignore"
touch "$base_dir/redis/Dockerfile" "$base_dir/redis/.dockerignore"
touch "$base_dir/ftp-server/Dockerfile" "$base_dir/ftp-server/.dockerignore"

# Check if the commands were successful
if [ $? -eq 0 ]; then
    echo -e "${GREEN}10_create_bonus_files.sh ended${NC}"
else
    echo -e "${RED}10_create_bonus_files.sh failed. Script terminating.${NC}"
    exit 1
fi
