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
