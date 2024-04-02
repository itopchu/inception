#!/bin/bash

# Color codes
CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${CYAN}04_allow_ports.sh started${NC}"

# Allow ports for connections
ufw enable
ufw allow 443
ufw allow 80
ufw allow 42

# Check if the commands were successful
if [ $? -eq 0 ]; then
    echo -e "${GREEN}04_allow_ports.sh ended${NC}"
else
    echo -e "${RED}04_allow_ports.sh failed. Script terminating.${NC}"
    exit 1
fi
