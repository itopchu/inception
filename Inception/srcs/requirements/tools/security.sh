#!/bin/bash

# This script adds security keys to .env file to make it reachable by docker-compose
# It also protects old values

username="${1:-itopchu}"
env_path=/home/$username/Inception/srcs/.env

# Get secret keys from wordpress api
curl -s https://api.wordpress.org/secret-key/1.1/salt/ -o keys.txt

# Loop through each line in the temporary file
while IFS= read -r line; do
    # Extract variable name and value from the line
    var_name=$(echo "$line" | sed -E "s/define\('([^']*)'.*/\1/")
    var_value=$(echo "$line" | sed -E "s/define\('[^']*',\s*'([^']*)'\);/\1/")

    # Check if variable name already exists in the .env file
    if grep -q "^$var_name=" $env_path && grep -q "^$var_name=." $env_path; then
        continue
    fi

    # Remove any existing variable from .env file
    sed -i "/^$var_name/d" $env_path

    # Append the variable and its value to the .env file if there's an '=' and non-empty value
    if [ -n "$var_value" ]; then
        echo "$var_name='$var_value'" >> $env_path
    fi
done < keys.txt

# Remove the temporary file
rm -f keys.txt