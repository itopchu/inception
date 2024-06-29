#!/bin/bash

sleep 10

echo "Setting up WordPress"

if [ -e "/var/www/html/wp-config.php" ];then
    echo "WordPress already installed. Executing server"
    exec "$@"
fi

mkdir -p "$WP_PATH"
wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar;
chmod +x wp-cli.phar; 
mv wp-cli.phar /usr/local/bin/wp;
cd "$WP_PATH";

wp core download --allow-root \

wp config create --allow-root \
                --dbname=$DB_NAME \
                --dbuser=$DB_USER \
                --dbpass=$DB_USER_PWD \
                --dbhost=$DB_HOST \
                --path=$WP_PATH
wp core install --allow-root \
                --url=$DOMAIN_NAME \
                --title="$WP_TITLE" \
                --admin_user="$WP_ADMIN" \
                --admin_password="$WP_ADMIN_PWD" \
                --admin_email="$WP_ADMIN_EMAIL" \
                --path="$WP_PATH"
wp user create --allow-root "$WP_USER_LOGIN" "$WP_USER_EMAIL" \
                --role=author \
                --user_pass="$WP_USER_PWD" \
                --path="$WP_PATH"
wp config shuffle-salts --allow-root \

chown -R www-data:www-data ${WP_PATH}
echo "WordPress installation complete"
exec "$@"