#!/bin/bash

# Exit if any command fails
set -e

username="${1:-itopchu}"

# Check if openssl is installed, install if not
if [! command -v openssl &> /dev/null]; then
    sudo apt update
    sudo apt install -y openssl
fi

# Move files to destination directory
destination="/home/$username/Inception/srcs/requirements/nginx/tools"
mkdir -p "$destination"

openssl req -x509 -nodes -newkey rsa:4096 \
	-keyout "$username.42.fr.key" \
	-out "$username.42.fr.crt" \
	-days 365 \
	-subj "/CN=$username.42.fr"

# Check if .crt and .key files already exist, move them if they don't
if [ ! -e "$destination/$username.42.fr.crt" ]; then
    mv "$username.42.fr.crt" "$destination"
    chmod 644 "$destination/$username.42.fr.crt"
fi

if [ ! -e "$destination/$username.42.fr.key" ]; then
    mv "$username.42.fr.key" "$destination"
    chmod 600 "$destination/$username.42.fr.key"
fi

# Remove intermediate files
rm -f "$username.42.fr.key" "$username.42.fr.crt"