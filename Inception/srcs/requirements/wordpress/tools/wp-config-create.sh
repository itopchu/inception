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
    # Create wp-config.php
    cat << EOF > /var/www/wp-config.php
<?php
define( 'DB_NAME', '${MYSQL_DATABASE}' );
define( 'DB_USER', '${MYSQL_USER}' );
define( 'DB_PASSWORD', '${MYSQL_PASSWORD}' );
define( 'DB_HOST', '${MYSQL_HOST}' );
define( 'DB_CHARSET', 'utf8' );
define( 'DB_COLLATE', '' );
define('FS_METHOD','direct');
define( 'AUTH_KEY',         '${AUTH_KEY}' );
define( 'SECURE_AUTH_KEY',  '${SECURE_AUTH_KEY}' );
define( 'LOGGED_IN_KEY',    '${LOGGED_IN_KEY}' );
define( 'NONCE_KEY',        '${NONCE_KEY}' );
define( 'AUTH_SALT',        '${AUTH_SALT}' );
define( 'SECURE_AUTH_SALT', '${SECURE_AUTH_SALT}' );
define( 'LOGGED_IN_SALT',   '${LOGGED_IN_SALT}' );
define( 'NONCE_SALT',       '${NONCE_SALT}' );
\$table_prefix = 'wp_';
define( 'WP_DEBUG', false );
if ( ! defined( 'ABSPATH' ) ) {
    define( 'ABSPATH', __DIR__ . '/' );
}
require_once ABSPATH . 'wp-settings.php';
EOF
fi

# Run additional WP-CLI commands
wp core install \
    --url="${DOMAIN_NAME}/wordpress" \
    --title="${WP_TITLE}" \
    --admin_user="${WP_ADMIN_USR}" \
    --admin_password="${WP_ADMIN_PWD}" \
    --admin_email="${WP_ADMIN_EMAIL}" \
    --skip-email

wp user create "${WP_USR}" "${WP_EMAIL}" \
    --role=author \
    --user_pass="${WP_PWD}"

wp theme install inspiro --activate