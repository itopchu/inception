#!/bin/bash

# Color codes
CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${CYAN}08_add_domain_for_user.sh started${NC}"

# Add domain for the user
hosts="/etc/hosts"
if [ ! -e "$hosts" ]; then
    echo -e "${RED}Error: File $hosts not found. Script terminating.${NC}"
    exit 1
fi

sed -i "/^127.0.0.1/s/localhost$/$target_username.42.fr localhost/" "$hosts"

# Check if the commands were successful
if [ $? -eq 0 ]; then
    echo -e "${GREEN}08_add_domain_for_user.sh ended${NC}"
else
    echo -e "${RED}08_add_domain_for_user.sh failed. Script terminating.${NC}"
    exit 1
fi
