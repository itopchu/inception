#!bin/bash

if [ ! -f "/var/www/wordpress/wp-config.php" ]; then

sed -i "s/username_here/$DB_USER/g" wordpress/wp-config-sample.php
sed -i "s/password_here/$DB_USER_PWD/g" wordpress/wp-config-sample.php
sed -i "s/localhost/mariadb/g" wordpress/wp-config-sample.php
sed -i "s/database_name_here/$DB_NAME/g" wordpress/wp-config-sample.php
cp wordpress/wp-config-sample.php wordpress/wp-config.php

wp core install \
	--allow-root \
	--path=/var/www/wordpress/ \
	--url="$DOMAIN_NAME" \
	--title="$WP_TITLE" \
	--admin_user="$WP_ADMIN_USER" \
	--admin_password="$WP_ADMIN_PWD" \
	--admin_email="$WP_ADMIN_EMAIL" \
	--skip-email \

wp user create \
	--allow-root \
	--path=/var/www/wordpress/ \
	"$WP_USER" \
	"$WP_USER_EMAIL" \
	--user_pass="$WP_USER_PWD"
fi

php-fpm7.4 -F
