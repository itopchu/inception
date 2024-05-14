#!/bin/bash

if [ $# -eq 0 ]; then
    username="itopchu"
else
    username="$1"
fi

# Set SSL certificate inputs
country="NL"
state="North Holland"
locality="Amsterdam"
organization="42"
unit="IT Department"
common_name="$username.42.fr"
email="$username@inception.com"

# Check if openssl is installed, install if not
if ! command -v openssl &> /dev/null; then
    sudo apt update
    sudo apt install -y openssl
fi

# Generate private key and certificate signing request
openssl genrsa -out server.key 2048
openssl req -new -key server.key -out server.csr -subj "/C=$country/ST=$state/L=$locality/O=$organization/OU=$unit/CN=$common_name/emailAddress=$email"

# Generate self-signed certificate
openssl x509 -req -days 365 -in server.csr -signkey server.key -out "$username.42.fr.crt"

# Generate separate key file
openssl rsa -in server.key -out "$username.42.fr.key"

# Move files to destination directory
destination="/home/$username/Inception/srcs/requirements/nginx/tools/"
mkdir -p "$destination"

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
rm -f server.key server.csr $username.42.fr.key $username.42.fr.crt