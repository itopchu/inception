#!/bin/bash

if [ ! -f "/var/www/wordpress/wp-config.php" ]; then

    # Replace placeholders in the wp-config-sample.php file with environment variables
    # Replace unique phrase placeholders with actual secret keys
    sed -e "s/username_here/$MYSQL_USER/g" \
        -e "s/password_here/$MYSQL_PASSWORD/g" \
        -e "s/localhost/$MYSQL_HOST/g" \
        -e "s/database_name_here/$MYSQL_DATABASE/g" \
		wordpress/wp-config-sample.php > wordpress/wp-config.php

    # Generate unique authentication keys and salts
    wp config shuffle-salts --path=/var/www/wordpress/ > /dev/null

    # Install WordPress
    wp core install \
        --allow-root \
        --path=/var/www/wordpress/ \
        --url="$DOMAIN_NAME" \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN_USR" \
        --admin_password="$WP_ADMIN_PWD" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --skip-email

    # Create a new user
    wp user create \
        --allow-root \
        --path=/var/www/wordpress/ \
        "$WP_USR" \
        "$WP_EMAIL" \
        --user_pass="$WP_PWD"
fi

php-fpm${PHP_VERSION} -F
