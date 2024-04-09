#!/bin/bash

# Color codes
CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${CYAN}01_setup_packages.sh started${NC}"

# Install necessary packages
apt update
apt upgrade
apt install -y sudo ufw docker docker-compose make openbox xinit kitty firefox-esr

# Check if the installation was successful
if [ $? -eq 0 ]; then
    echo -e "${GREEN}01_setup_packages.sh ended${NC}"
else
    echo -e "${RED}01_setup_packages.sh failed. Script terminating.${NC}"
    exit 1
fi
