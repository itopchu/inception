# base image for docker
FROM debian:bullseye

# Port for webserv connection
EXPOSE 9000

ARG DOMAIN_NAME
ARG MYSQL_DATABASE
ARG MYSQL_USER
ARG MYSQL_PASSWORD
ARG MYSQL_ROOT_PASSWORD
ARG MYSQL_HOST
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

# gettext-base is needed for env expasion
# curl is needed to download WordPress Command Line Interface.
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y \
    php \
    php-fpm \
    php-json \
    php-curl \
    php-mbstring \
    php-xml \
    php-zip \
    openssl \
    php-common \
    php-mysql \
    wget \
    unzip \
    gettext-base \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# RUN PHP_VERSION=$(dpkg -l | grep '^ii' | grep 'php' | awk '{split($3, ver, "."); print ver[1]"."ver[2]}')
# ENV PHP_VERSION=${PHP_VERSION}
ARG PHP_VERSION=7.4

# Configure PHP-FPM
RUN sed -i "s|^listen = 127.0.0.1:9000|listen = /run/php/php${PHP_VERSION}-fpm.sock|g" /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf && \
    sed -i "s|^;listen.owner = nobody|listen.owner = www-data|g" /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf && \
    sed -i "s|^;listen.group = nobody|listen.group = www-data|g" /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf

# Set working directory
WORKDIR /var/www

# Download and install WordPress
RUN wget https://wordpress.org/latest.tar.gz && \
    tar -xzvf latest.tar.gz && \
    cp -rf wordpress/* . && \
    rm -rf wordpress latest.tar.gz

# Copy and execute script for creating wp-config.php
COPY ./tools/wp-config-create.sh ./wp-config-create.sh.template
RUN envsubst '$DOMAIN_NAME $MYSQL_DATABASE $MYSQL_USER $MYSQL_PASSWORD $MYSQL_HOST $AUTH_KEY $SECURE_AUTH_KEY $LOGGED_IN_KEY $NONCE_KEY $AUTH_SALT $SECURE_AUTH_SALT $LOGGED_IN_SALT $NONCE_SALT $WP_TITLE $WP_ADMIN_USR $WP_ADMIN_PWD $WP_ADMIN_EMAIL $WP_USR $WP_EMAIL $WP_PWD' \
    < ./wp-config-create.sh.template > ./wp-config-create.sh && \
    rm -f ./wp-config-create.sh.template && \
    bash ./wp-config-create.sh && \
    rm ./wp-config-create.sh && \
    chmod -R 0777 wp-content/

WORKDIR /var/www/html/wordpress

# Start PHP-FPM
CMD ["php-fpm${PHP_VERSION}", "-F"]