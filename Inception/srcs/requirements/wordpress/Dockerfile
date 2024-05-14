# base image for docker
FROM debian:bullseye

# Port for webserv connection
EXPOSE 9000

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
ARG PHP_VERSION=7.4

# gettext-base is needed for env expasion
# curl is needed to download WordPress Command Line Interface.
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y \
    php${PHP_VERSION} \
    php${PHP_VERSION}-fpm \
    php${PHP_VERSION}-mysqli \
    php${PHP_VERSION}-json \
    php${PHP_VERSION}-curl \
    php${PHP_VERSION}-dom \
    php${PHP_VERSION}-exif \
    php${PHP_VERSION}-fileinfo \
    php${PHP_VERSION}-mbstring \
    php${PHP_VERSION}-openssl \
    php${PHP_VERSION}-xml \
    php${PHP_VERSION}-zip \
    wget \
    unzip \
    gettext-base \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Configure PHP-FPM
RUN sed -i "s|listen = 127.0.0.1:9000|listen = 9000|g" /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf && \
    sed -i "s|;listen.owner = nobody|listen.owner = nobody|g" /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf && \
    sed -i "s|;listen.group = nobody|listen.group = nobody|g" /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf

# Set working directory
WORKDIR /var/www

# Download and install WordPress
RUN wget https://wordpress.org/latest.tar.gz && \
    tar -xzvf latest.tar.gz && \
    cp -rf wordpress/* . && \
    rm -rf wordpress latest.tar.gz

# Copy and execute script for creating wp-config.php
COPY ./requirements/wordpress/conf/wp-config-create.sh .
RUN sh wp-config-create.sh && rm wp-config-create.sh && \
    chmod -R 0777 wp-content/

# Start PHP-FPM
CMD ["/usr/sbin/php-fpm${PHP_VERSION}", "-F"]