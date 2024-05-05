RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    php${WP_PHP_VERSION} \
    php${WP_PHP_VERSION}-fpm \
    php${WP_PHP_VERSION}-mysqli \
    php${WP_PHP_VERSION}-json \
    php${WP_PHP_VERSION}-curl \
    php${WP_PHP_VERSION}-dom \
    php${WP_PHP_VERSION}-exif \
    php${WP_PHP_VERSION}-fileinfo \
    php${WP_PHP_VERSION}-mbstring \
    php${WP_PHP_VERSION}-openssl \
    php${WP_PHP_VERSION}-xml \
    php${WP_PHP_VERSION}-zip \
    php${WP_PHP_VERSION}-redis \
    wget \
    unzip && \
    sed -i "s|listen = 127.0.0.1:9000|listen = 9000|g" \
      /etc/php/${WP_PHP_VERSION}/fpm/pool.d/www.conf && \
    sed -i "s|;listen.owner = www-data|listen.owner = www-data|g" \
      /etc/php/${WP_PHP_VERSION}/fpm/pool.d/www.conf && \
    sed -i "s|;listen.group = www-data|listen.group = www-data|g" \
      /etc/php/${WP_PHP_VERSION}/fpm/pool.d/www.conf && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www
RUN wget https://wordpress.org/latest.zip && \
    unzip latest.zip && \
    cp -rf wordpress/* . && \
    rm -rf wordpress latest.zip
COPY ./conf/wp-config-create.sh .
RUN sh wp-config-create.sh && rm wp-config-create.sh && \
    chmod -R 0777 wp-content/

CMD ["/usr/sbin/php-fpm${WP_PHP_VERSION}", "-F"]