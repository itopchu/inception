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

# gettext-base is needed for env expasion
# curl is needed to download WordPress Command Line Interface.
RUN apt-get update
RUN apt-get install -y \
    php7.3 \
    php-mysqli \
    php-fpm \
    mariadb-client \
    gettext-base \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY ./www.conf /etc/php/7.3/fpm/pool.d

ADD https://wordpress.org/wordpress-6.5.3.tar.gz /var/www/
RUN cd /var/www && tar -xzvf wordpress.org/wordpress-6.5.3.tar.gz
RUN rm -f /var/www/wordpress.org/wordpress-6.5.3.tar.gz
RUN rm -f /var/www/wordpress/wp-config-sample.php
COPY ./conf/wp-config.php ./var/www/wordpress/wp-config.php.template
RUN envsubst '$MYSQL_DATABASE $MYSQL_USER $MYSQL_PASSWORD $MYSQL_HOST $AUTH_KEY $SECURE_AUTH_KEY $LOGGED_IN_KEY $NONCE_KEY $AUTH_SALT $SECURE_AUTH_SALT $LOGGED_IN_SALT $NONCE_SALT' < ./var/www/wordpress/wp-config.php.template > ./var/www/wordpress/wp-config.php \
    && rm -f /var/www/html/wp-config.php.template

RUN mkdir -p ./run/php/
CMD ./user/sbin/php-fpm7.3 -F
