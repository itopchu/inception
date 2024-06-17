FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    php-fpm php-mysql curl \
    && curl -O https://wordpress.org/latest.tar.gz \
    && tar -xzf latest.tar.gz \
    && mkdir -p /var/www/html/ \
    && mv wordpress /var/www/html \
    && chown -R www-data:www-data /var/www/html \
    && mkdir -p /run/php

COPY conf/wp-config.php /var/www/html/wp-config.php
# COPY tools/index.html /var/www/html/index.html
COPY tools/wp-setup.sh /usr/local/bin/wp-setup.sh

RUN chmod +x /usr/local/bin/wp-setup.sh

CMD ["/usr/local/bin/wp-setup.sh"]
