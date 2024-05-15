#!/bin/bash

# Install WP-CLI dependencies
apt-get update && apt-get install -y \
    wget \
    unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Download and install WP-CLI
wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

# Check if wp-config.php already exists
if [ ! -f "/var/www/wp-config.php" ]; then
    # place wp-config.php
    mv /tmp/wp-config.php /var/www/wp-config.php
else
    rm -f /tmp/wp-config.php
fi

# Run additional WP-CLI commands
wp --allow-root core install \
    --url="${DOMAIN_NAME}/wordpress" \
    --title="${WP_TITLE}" \
    --admin_user="${WP_ADMIN_USR}" \
    --admin_password="${WP_ADMIN_PWD}" \
    --admin_email="${WP_ADMIN_EMAIL}" \
    --skip-email

wp --allow-root user create "${WP_USR}" "${WP_EMAIL}" \
    --role=author \
    --user_pass="${WP_PWD}"

wp --allow-root theme install inspiro --activate