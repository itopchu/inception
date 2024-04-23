#!/bin/bash

# Color codes
CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${CYAN}04_restart_ssh_service.sh started${NC}"

# Restart ssh service
service ssh restart
service sshd restart

# Check if the restart was successful
if [ $? -eq 0 ]; then
    echo -e "${GREEN}04_restart_ssh_service.sh ended${NC}"
else
    echo -e "${RED}04_restart_ssh_service.sh failed. Script terminating.${NC}"
    exit 1
fi
