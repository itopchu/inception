# base image for docker
FROM debian:bullseye

# Port for webserv connection
EXPOSE 9000

WORKDIR /var/www/html

ARG PHP_VERSION

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y \
    php php-mysql php-fpm mariadb-client

RUN sed -i 's#listen = /run/php/php${PHP_VERSION}-fpm.sock#listen = 0.0.0.0:9000#' /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf

# Step 1: Download the latest version of WordPress
# Step 2: Extract the downloaded tar.gz file
# Step 3: Download the WP-CLI tool
# Step 4: Make the WP-CLI tool executable
# Step 5: Move WP-CLI to a directory in the system PATH
# Step 6: Remove the downloaded tar.gz file to clean up
# Step 7: Create a directory for PHP-FPM to run
# Step 8: Allow root commands

RUN wget https://wordpress.org/latest.tar.gz && \
    tar -xzvf latest.tar.gz && \
    wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp && \
    rm latest.tar.gz && \
    mkdir -p /run/php && \
    cd /var/www/html && wp core download --allow-root

COPY ./conf/www.conf /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf

RUN cd /var/www/html && wp core download --allow-root

COPY ./tools/wp-config-create.sh .
RUN chmod +x wp-config-create.sh

CMD ["sh", "wp-config-create.sh"]