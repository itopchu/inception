#!/bin/bash

# wait for mysql to start
sleep 6

mv wp-config-sample.php wp-config.php && wp config set SERVER_PORT 3306 --allow-root

wp config set DB_NAME $MYSQL_DATABASE --allow-root --path=/var/www/html
wp config set DB_USER $MYSQL_USR --allow-root --path=/var/www/html
wp config set DB_PASSWORD $MYSQL_PASSWORD --allow-root --path=/var/www/html
wp config set DB_HOST $MYSQL_HOST --allow-root --path=/var/www/html

wp core install --url=$DOMAIN_NAME --title=$WP_TITLE --admin_user=$WP_ADMIN_USR  --admin_password=$WP_ADMIN_PWD --admin_email=$WP_ADMIN_EMAIL --allow-root --path=/var/www/html
wp user create $WP_USR $WP_EMAIL --role=author --user_pass=$WP_PWD --allow-root --path=/var/www/html

php-fpm${PHP_VERSION} -F
