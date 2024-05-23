#!/bin/bash

if [ ! -f "/var/www/wordpress/wp-config.php" ]; then

    # Replace placeholders in the wp-config-sample.php file with environment variables
	sed -i "s/username_here/$MYSQL_USER/g" wordpress/wp-config-sample.php
	sed -i "s/password_here/$MYSQL_PASSWORD/g" wordpress/wp-config-sample.php
	sed -i "s/localhost/$MYSQL_HOST/g" wordpress/wp-config-sample.php
	sed -i "s/database_name_here/$MYSQL_DATABASE/g" wordpress/wp-config-sample.php

    # Replace unique phrase placeholders with actual secret keys
    sed -i "s/put your unique phrase here/$AUTH_KEY/g" wordpress/wp-config-sample.php
    sed -i "s/put your unique phrase here/$SECURE_AUTH_KEY/g" wordpress/wp-config-sample.php
    sed -i "s/put your unique phrase here/$LOGGED_IN_KEY/g" wordpress/wp-config-sample.php
    sed -i "s/put your unique phrase here/$NONCE_KEY/g" wordpress/wp-config-sample.php
    sed -i "s/put your unique phrase here/$AUTH_SALT/g" wordpress/wp-config-sample.php
    sed -i "s/put your unique phrase here/$SECURE_AUTH_SALT/g" wordpress/wp-config-sample.php
    sed -i "s/put your unique phrase here/$LOGGED_IN_SALT/g" wordpress/wp-config-sample.php
    sed -i "s/put your unique phrase here/$NONCE_SALT/g" wordpress/wp-config-sample.php

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
fi

php-fpm${PHP_VERSION} -F
