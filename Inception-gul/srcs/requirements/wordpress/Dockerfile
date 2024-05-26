# base image for docker
FROM debian:bullseye


# sed -i 's#listen = /run/php/php7.4-fpm.sock#listen = 0.0.0.0:9000#' /etc/php/7.4/fpm/pool.d/www.conf && \
RUN apt-get update && apt install -y curl tar wget && \
    apt install -y php7.4-fpm php-mysql

WORKDIR /var/www

RUN wget https://wordpress.org/latest.tar.gz && \
    tar -xzvf latest.tar.gz && \
    wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp && \
    rm latest.tar.gz && \
    mkdir -p /run/php && \
    chown -R www-data:www-data /var/www/wordpress && \
    chmod -R 755 /var/www/wordpress 

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

COPY /tools/wp.sh /tmp/
RUN chmod +x /tmp/wp.sh

CMD ["/tmp/wp.sh"]