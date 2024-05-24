#!/bin/bash

if [ ! -f "/var/www/wordpress/wp-config.php" ]; then

    # Replace placeholders in the wp-config-sample.php file with environment variables
    # Replace unique phrase placeholders with actual secret keys
	sed -i'' -e "s/username_here/$MYSQL_USER/g" \
			-e "s/password_here/$MYSQL_PASSWORD/g" \
			-e "s/localhost/$MYSQL_HOST/g" \
			-e "s/database_name_here/$MYSQL_DATABASE/g" \
			-e "s/'AUTH_KEY',         'put your unique phrase here'/'AUTH_KEY',         '$AUTH_KEY'/g" \
			-e "s/'SECURE_AUTH_KEY',  'put your unique phrase here'/'SECURE_AUTH_KEY',  '$SECURE_AUTH_KEY'/g" \
			-e "s/'LOGGED_IN_KEY',    'put your unique phrase here'/'LOGGED_IN_KEY',    '$LOGGED_IN_KEY'/g" \
			-e "s/'NONCE_KEY',        'put your unique phrase here'/'NONCE_KEY',        '$NONCE_KEY'/g" \
			-e "s/'AUTH_SALT',        'put your unique phrase here'/'AUTH_SALT',        '$AUTH_SALT'/g" \
			-e "s/'SECURE_AUTH_SALT', 'put your unique phrase here'/'SECURE_AUTH_SALT', '$SECURE_AUTH_SALT'/g" \
			-e "s/'LOGGED_IN_SALT',   'put your unique phrase here'/'LOGGED_IN_SALT',   '$LOGGED_IN_SALT'/g" \
			-e "s/'NONCE_SALT',       'put your unique phrase here'/'NONCE_SALT',       '$NONCE_SALT'/g" wordpress/wp-config-sample.php

    # Copy the modified wp-config-sample.php to wp-config.php
    cp wordpress/wp-config-sample.php wordpress/wp-config.php

    wp core install \
	    --allow-root \
	    --path=/var/www/wordpress/ \
	    --url="$DOMAIN_NAME" \
	    --title="$WP_TITLE" \
	    --admin_user="$WP_ADMIN_USR" \
	    --admin_password="$WP_ADMIN_PWD" \
	    --admin_email="$WP_ADMIN_EMAIL" \
	    --skip-email

    wp user create \
	    --allow-root \
	    --path=/var/www/wordpress/ \
	    "$WP_USR" \
	    "$WP_EMAIL" \
	    --user_pass="$WP_PWD"

    wp config create \
        --allow-root \
        --path=/var/www/wordpress/ \
        --dbuser="$MYSQL_USER" \
        --dbpass="$MYSQL_PASSWORD" \
        --dbname="$MYSQL_DATABASE" \
        --dbhost="$MYSQL_HOST"
fi

php-fpm${PHP_VERSION} -F
