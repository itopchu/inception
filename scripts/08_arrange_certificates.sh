#!/bin/bash

# Color codes
CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${CYAN}07_arrange_certificates.sh started${NC}"

# Certificates arrangement
sudo apt update -y && sudo apt install -y wget curl libnss3-tools
curl -s https://api.github.com/repos/FiloSottile/mkcert/releases/latest| grep browser_download_url  | grep linux-amd64 | cut -d '"' -f 4 | wget -qi -
mv mkcert-v*-linux-amd64 mkcert && chmod a+x mkcert
sudo mv mkcert /usr/local/bin/

while true; do
    read -p "Are project files set? y/n: " status

    if [ -z "$status" ]; then
        echo "Please enter a valid response (y/n)."
    elif [ "$status" == "y" ] || [ "$status" == "Y" ]; then
        echo "Project files are set. Proceeding with certificates arrangement."
        break
    elif [ "$status" == "n" ] || [ "$status" == "N" ]; then
        echo "Project files are not set. Exiting..."
        exit 1
    else
		echo "Unexpected character received. Assuming 'n'. Exiting..."
        exit 1
    fi
done

mkcert "$target_username.42.fr"

# Check if mkcert command was successful
if [ $? -ne 0 ]; then
    echo -e "${RED}Failed to generate certificates.${NC}"
    exit 1
fi

# Check if target directory exists and move certificate files
target_dir="/home/$target_username/Inception/srcs/requirements/tools"
if [ ! -d "$target_dir" ]; then
    echo -e "${RED}Target directory $target_dir does not exist.${NC}"
    exit 1
fi

mv "$target_username.42.fr-key.pem" "$target_dir/$target_username.42.fr.key"
mv "$target_username.42.fr.pem" "$target_dir/$target_username.42.fr.crt"

# Check if the move commands were successful
if [ $? -eq 0 ]; then
    echo -e "${GREEN}Certificates arranged successfully.${NC}"
    echo -e "${GREEN}07_arrange_certificates.sh ended.${NC}"
else
    echo -e "${RED}Failed to arrange certificates.${NC}"
    echo -e "${RED}07_arrange_certificates.sh failed. Script terminating.${NC}"
    exit 1
fi
