#!/bin/bash

if [ ! -f "/var/www/wordpress/wp-config.php" ]; then

    # Replace placeholders in wp-config-sample.php and create wp-config.php
    sed -i "s/database_name_here/$MYSQL_NAME/g" /var/www/wordpress/wp-config-sample.php
    sed -i "s/username_here/$MYSQL_USR/g" /var/www/wordpress/wp-config-sample.php
    sed -i "s/password_here/$MYSQL_PWD/g" /var/www/wordpress/wp-config-sample.php
    sed -i "s/localhost/$MYSQL_HOST/g" /var/www/wordpress/wp-config-sample.php
    cp /var/www/wordpress/wp-config-sample.php /var/www/wordpress/wp-config.php

    # Install WordPress using wp-cli
    wp core install \
        --allow-root \
        --path=/var/www/wordpress/ \
        --url="$DOMAIN_NAME" \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN_USR" \
        --admin_password="$WP_ADMIN_PWD" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --skip-email

    # Create a second WordPress user
    wp user create \
        --allow-root \
        --path=/var/www/wordpress/ \
        "$WP_USR" \
        "$WP_EMAIL" \
        --user_pass="$WP_PWD"
fi

# Start PHP-FPM
php-fpm${PHP_VERSION} -F
