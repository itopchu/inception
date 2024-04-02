#!/bin/bash

# Color codes
CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${CYAN}05_add_user_to_groups.sh started${NC}"

while true; do
    # Add user to sudoers and docker groups
    read -p "Enter the username to add to sudoers and docker group: " username

    if [ -z "$username" ]; then
        echo "Please enter a valid username."
    elif id "$username" &>/dev/null; then
        export target_username="$username"  # Export the variable
        echo "$target_username ALL=(ALL:ALL) ALL" >> /etc/sudoers
        sudo usermod -aG docker "$target_username"
        echo -e "${GREEN}User $target_username added to sudoers and docker group successfully.${NC}"
        break
    else
        echo -e "${RED}05_add_user_to_groups.sh failed. Invalid username. Script terminating.${NC}"
        exit 1
    fi
done
