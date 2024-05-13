# base image for docker
FROM debian:bullseye

# Port for webserv connection
EXPOSE 9000

# gettext-base is needed for env expasion
# curl is needed to download WordPress Command Line Interface.
RUN apt-get update \
    && apt-get install -y \
    gettext-base \
    php-fpm \
    php-mysql \
    curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*


RUN if [ ! -d /var/www/html/ ]; then \
        mkdir -p /var/www/html; \
        curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar; \
        chmod +x wp-cli.phar; \
        mv wp-cli.phar /usr/local/bin/wp; \
        wp core download --allow-root; \
    fi

ARG DOMAIN_NAME
ARG MYSQL_DATABASE
ARG MYSQL_USER
ARG MYSQL_PASSWORD
ARG AUTH_KEY
ARG SECURE_AUTH_KEY
ARG LOGGED_IN_KEY
ARG NONCE_KEY
ARG AUTH_SALT
ARG SECURE_AUTH_SALT
ARG LOGGED_IN_SALT
ARG NONCE_SALT
ARG WP_TITLE
ARG WP_ADMIN_USR
ARG WP_ADMIN_PWD
ARG WP_ADMIN_EMAIL
ARG WP_USR
ARG WP_EMAIL
ARG WP_PWD

# Config cloning from host machine
COPY ./conf/wp-config.php /var/www/html/wp-config.php.template

# Variable expansion in config file
RUN wp core install --url=$DOMAIN_NAME/ --title=$WP_TITLE --admin_user=$WP_ADMIN_USR --admin_password=$WP_ADMIN_PWD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root \
    && wp user create $WP_USR $WP_EMAIL --role=author --user_pass=$WP_PWD --allow-root \
    && mkdir -p /run/php \
    && mkdir -p /var/www/html \
    && envsubst '$MYSQL_DATABASE $MYSQL_USER $MYSQL_PASSWORD $MYSQL_HOST $AUTH_KEY $SECURE_AUTH_KEY $LOGGED_IN_KEY $NONCE_KEY $AUTH_SALT $SECURE_AUTH_SALT $LOGGED_IN_SALT $NONCE_SALT' < /var/www/html/wp-config.php.template > /var/www/html/wp-config.php \
    && rm -f /var/www/html/wp-config.php.template

# -fpm.sock listen to 9000
RUN php_version=$(php -v | grep -P 'PHP \K[0-9]+\.[0-9]+' | head -n 1) \
    && sed -i "s/listen = \/run\/php\/php${php_version}-fpm.sock/listen = 9000/g" /etc/php/${php_version}/fpm/pool.d/www.conf \
    && rm -f /tmp/php_version

RUN PHP_FPM_PATH=$(which php-fpm)
# Start Wordpress
CMD ["/bin/bash", "-c", "$PHP_FPM_PATH -F"]