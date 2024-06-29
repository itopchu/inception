#!/bin/bash

sleep 10

echo "Configuring WordPress..."

if [ -e "/var/www/html/wp-config.php" ]; then
    echo "WordPress already installed"
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
                --dbpass=$DB_PASSWORD \
                --dbhost=$DB_HOST \
                --path=$WP_PATH

wp core install --allow-root \
               --url="$WP_URL" \
               --title="$WP_TITLE" \
               --admin_user="$WP_ADMIN_LOGIN" \
               --admin_password="$WP_ADMIN_PASSWORD" \
               --admin_email="$WP_ADMIN_EMAIL" \

wp user create --allow-root \
                "$WP_USER_LOGIN" \
                "$WP_USER_EMAIL" \
                --role=author \
                --user_pass="$WP_USER_PASSWORD" \

chown -R www-data:www-data /var/www/html

echo "WordPress installed and configured successfully"

exec "$@"
