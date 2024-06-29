FROM debian:bullseye

EXPOSE 9000

RUN apt-get update && apt-get install -y \
    php7.4 \
    php-fpm \
    php-mysql \
    mariadb-client \
    wget \
	sendmail

# Create the directory for pid file
RUN mkdir /run/php/ && chmod 755 /run/php/

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/
COPY ./tools/config.sh /tmp/

RUN chmod +x /tmp/config.sh

ENTRYPOINT ["/tmp/config.sh"]

CMD ["php-fpm7.4", "-F"]





# FROM debian:bullseye

# RUN apt-get update && apt-get install -y \
#     php-fpm php-mysql curl \
#     && curl -O https://wordpress.org/latest.tar.gz \
#     && tar -xzf latest.tar.gz \
#     && mkdir -p /var/www/html/ \
#     && mv wordpress/* /var/www/html \
#     && rmdir wordpress/ \
#     && chown -R www-data:www-data /var/www/html \
#     && mkdir -p /run/php \
#     && curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
#     && chmod +x wp-cli.phar \
#     && mv wp-cli.phar /usr/local/bin/wp

# COPY conf/wp-config.php /var/www/html/wp-config.php
# COPY tools/wp-setup.sh /usr/local/bin/wp-setup.sh

# RUN chmod +x /usr/local/bin/wp-setup.sh

# CMD ["/usr/local/bin/wp-setup.sh"]
