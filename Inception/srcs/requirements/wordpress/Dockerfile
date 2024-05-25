# base image for docker
FROM debian:bullseye

# Port for webserv connection
EXPOSE 9000

ARG PHP_VERSION

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y \
    php${PHP_VERSION}-fpm \
    php-mysql \
    wget \
    curl \
    mariadb-client \
    && apt-get clean

# Create directory for WordPress
RUN mkdir -p /var/www/wordpress

# Download and set up WordPress
RUN cd /tmp && \
    wget https://wordpress.org/latest.tar.gz && \
    tar -xzvf latest.tar.gz && \
    wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp && \
    rm latest.tar.gz && \
    mkdir -p /run/php

# Set permissions for WordPress directory
RUN chown -R www-data:www-data /var/www/wordpress && \
    chmod -R 755 /var/www/wordpress

# Copy PHP-FPM pool configuration
COPY ./conf/www.conf /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf

# Copy and set permissions for the WordPress configuration script
COPY ./tools/wp-config-create.sh /usr/local/bin/wp-config-create.sh
RUN chmod +x /usr/local/bin/wp-config-create.sh

# Set the working directory
WORKDIR /var/www/wordpress

# Run the WordPress configuration script
CMD ["sh", "/usr/local/bin/wp-config-create.sh"]