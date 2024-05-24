#!/bin/bash

cd /var/www/html && wp core download --allow-root

if [ ! -f "/var/www/wordpress/wp-config.php" ]; then

# cd /var/www

sed -i "s/username_here/$MYSQL_USR/g" wordpress/wp-config-sample.php
sed -i "s/password_here/$MYSQL_PWD/g" wordpress/wp-config-sample.php
sed -i "s/localhost/$MYSQL_HOST/g" wordpress/wp-config-sample.php
sed -i "s/database_name_here/$MYSQL_NAME/g" wordpress/wp-config-sample.php
cp wordpress/wp-config-sample.php wordpress/wp-config.php

wp core install \
	--allow-root \
	--path=/var/www/wordpress/ \
	--url="$DOMAIN_NAME" \
	--title="$WP_TITLE" \
	--admin_user="$WP_ADMIN_USR" \
	--admin_password="$WP_ADMIN_PWD" \
	--admin_email="$WP_ADMIN_EMAIL" \
	--skip-email \

wp user create \
	--allow-root \
	--path=/var/www/wordpress/ \
	"$WP_USR" \
	"$WP_EMAIL" \
	--user_pass="$WP_PWD"
fi

php-fpm${PHP_VERSION} -F