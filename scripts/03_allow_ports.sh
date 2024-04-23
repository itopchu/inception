#!/bin/bash

# Color codes
CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${CYAN}03_allow_ports.sh started${NC}"

# Allow ports for connections
ufw allow 443/tcp
ufw allow 80/tcp
ufw allow 2222/tcp
ufw enable

# Check if the commands were successful
if [ $? -eq 0 ]; then
    echo -e "${GREEN}03_allow_ports.sh ended${NC}"
else
    echo -e "${RED}03_allow_ports.sh failed. Script terminating.${NC}"
    exit 1
fi
