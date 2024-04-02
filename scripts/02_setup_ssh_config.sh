#!/bin/bash

# Color codes
CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${CYAN}02_setup_ssh_config.sh started${NC}"

# Edit sshd_config
sshd="/etc/ssh/sshd_config"
if [ ! -e "$sshd" ]; then
    echo -e "${RED}Error: File $sshd not found. Script terminating.${NC}"
    exit 1
fi

sed -i \
    -e 's/#Port 22/Port 42/' \
    -e 's/#PermitRootLogin yes/PermitRootLogin yes/' \
    -e 's/#PubkeyAuthentication no/PubkeyAuthentication no/' \
    -e 's/#PasswordAuthentication yes/PasswordAuthentication yes/' \
    "$sshd"

# Check if the modifications were successful
if [ $? -eq 0 ]; then
    echo -e "${GREEN}02_setup_ssh_config.sh ended${NC}"
else
    echo -e "${RED}02_setup_ssh_config.sh failed. Script terminating.${NC}"
    exit 1
fi
