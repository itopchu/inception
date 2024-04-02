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
    echo "Project files are not set. Certificates skipped"
        break
    elif [ "$status" == "n" ] || [ "$status" == "N" ]; then
        echo "Project files are not set. Exiting..."
        exit 1
    else
		echo "Unexpected character received. Handled as 'n'. Certificates skipped"
        exit 1
    fi
done

mkcert $target_username.42.fr
mv $target_username.42.fr-key.pem home/$target_username/Inception/srcs/requirements/tools/$target_username.42.fr.key
mv $target_username.42.fr.pem home/$target_username/Inception/srcs/requirements/tools/$target_username.42.fr.crt

# Check if the commands were successful
if [ $? -eq 0 ]; then
    echo -e "${GREEN}07_arrange_certificates.sh ended${NC}"
else
    echo -e "${RED}07_arrange_certificates.sh failed. Script terminating.${NC}"
    exit 1
fi
