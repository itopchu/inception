# base image for docker
FROM debian:bullseye

# Port for webserv connection
EXPOSE 9000

WORKDIR /var/www

ARG PHP_VERSION

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y \
    php${PHP_VERSION}-fpm php-mysql wget tar \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Step 1: Download the latest version of WordPress
# Step 2: Extract the downloaded tar.gz file
# Step 3: Download the WP-CLI tool
# Step 4: Make the WP-CLI tool executable
# Step 5: Move WP-CLI to a directory in the system PATH
# Step 6: Remove the downloaded tar.gz file to clean up
# Step 7: Create a directory for PHP-FPM to run
# Step 8: Change the ownership of the WordPress directory to www-data user and group
# Step 9: Set the permissions of the WordPress directory to 755

RUN wget https://wordpress.org/latest.tar.gz && \
    tar -xzvf latest.tar.gz && \
    wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp && \
    rm latest.tar.gz && \
    mkdir -p /run/php && \
    chown -R www-data:www-data /var/www/wordpress && \
    chmod -R 755 /var/www/wordpress

COPY ./conf/www.conf /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf

COPY ./tools/wp-config-create.sh .

CMD ["sh", "wp-config-create.sh"]