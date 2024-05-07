#!/bin/bash

# Color codes
CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${CYAN}11_fill_files.sh started${NC}"

echo 'NAME = inception' > /home/$target_username/Inception/Makefile
echo "USER = $target_username" >> /home/$target_username/Inception/Makefile

echo 'all:
	@bash -c "mkdir -p /home/$(USER)/data/{wordpress/,mariadb/}"
	@docker-compose -f ./srcs/docker-compose.yml up -d

build:
	@bash -c "mkdir -p /home/$(USER)/data/{wordpress/,mariadb/}"
	@docker-compose -f ./srcs/docker-compose.yml up -d --build

down:
	@docker-compose -f ./srcs/docker-compose.yml down

re: down
	@docker-compose -f ./srcs/docker-compose.yml up -d --build

clean: down
	@docker system prune -a
	@bash -c (rm -rf /home/$(USER)/data)

fclean:
	@printf "Total clean of all configurations docker\n"
	@bash -c (rm -rf /home/$(USER)/data)
	@docker stop $$(docker ps -qa)
	@docker system prune --all --force --volumes
	@docker network prune --force
	@docker volume prune --force

.PHONY	: all build down re clean fclean' >> /home/$target_username/Inception/Makefile

echo -e "${GREEN}11_fill_files.sh ended${NC}"
echo "USER_NAME=$target_username" > /home/$target_username/Inception/srcs/.env
echo "DOMAIN_NAME=$target_username.42.fr" >> /home/$target_username/Inception/srcs/.env
echo "WP_TITLE=Inception
WP_PHP_VERSION=8.3
DB_HOST=mariadb
DB_NAME=wordpress
DB_ROOT=rootpass
DB_USER=wpuser
DB_PASSWORD=wppass
DB_CHARSET=utf8" >> /home/$target_username/Inception/srcs/.env

echo "version: '3.3'

services:

  nginx:
    env_file: .env
    build: requirements/nginx/
    container_name: nginx
    restart: always
    environment:
      DOMAIN_NAME: \${DOMAIN_NAME}
    ports:
      - \"443:443\"
      - \"80:80\"
    volumes:
      - /home/\${USER_NAME}/data/wordpress:/var/www/html
    networks:
      - app-network

  mariadb:
    env_file: .env
    build: requirements/mariadb/
    container_name: mariadb
    restart: always
    environment:
      DB_NAME: \${DB_NAME}
      DB_USER: \${DB_USER}
      DB_PASSWORD: \${DB_PASSWORD}
      DB_ROOT: \${DB_ROOT}
      WP_PHP_VERSION: \${WP_PHP_VERSION}
    volumes:
      - mariadb_data:/var/lib/mysql
    ports:
      - \"3306:3306\"
    networks:
      - app-network

  wordpress:
    env_file: .env
    build: requirements/wordpress/
    container_name: wordpress
    depends_on:
      - mariadb
    restart: always
    env_file:
      - .env
    volumes:
      - wordpress_data:/var/www/
    ports:
      - \"9000:9000\"
    networks:
      - app-network

networks:
  app-network:
    driver: bridge

volumes:
  wordpress_data:
    driver: local
    driver_opts:
      type: none
      device: /home/\${USER_NAME}/data/wordpress
      o: bind
  mariadb_data:
    driver: local
    driver_opts:
      type: none
      device: /home/\${USER_NAME}/data/mariadb
      o: bind" > /home/$target_username/Inception/srcs/docker-compose.yml

echo 'FROM debian:bullseye

EXPOSE 3306

RUN apt-get update && apt-get install -y mariadb-server

COPY ./conf/ /etc/mysql/mariadb.conf.d/
COPY ./tools /var/www/

RUN echo "DB_ROOT: ${DB_ROOT}" && \
    echo "DB_NAME: ${DB_NAME}" && \
    echo "DB_USER: ${DB_USER}" && \
    echo "DB_PASSWORD: ${DB_PASSWORD}"

RUN sed -i "s|\\${DB_ROOT}|${DB_ROOT}|g" /var/www/initial_db.sql && \
    sed -i "s|\\${DB_NAME}|${DB_NAME}|g" /var/www/initial_db.sql && \
    sed -i "s|\\${DB_USER}|${DB_USER}|g" /var/www/initial_db.sql && \
    sed -i "s|\\${DB_PASSWORD}|${DB_PASSWORD}|g" /var/www/initial_db.sql

COPY ./tools/startup.sh /usr/local/bin/startup.sh
RUN chmod +x /usr/local/bin/startup.sh

ENTRYPOINT ["/usr/local/bin/startup.sh"]' > /home/$target_username/Inception/srcs/requirements/mariadb/Dockerfile

echo '#!/bin/bash

service mariadb start

mysql < /var/www/initial_db.sql

rm -f /var/www/initial_db.sql

rm -f "$0"

exec mysqld' > /home/$target_username/Inception/srcs/requirements/mariadb/tools/startup.sh

echo '[mysqld]
character-set-server = utf8mb4
collation-server = utf8mb4_unicode_ci
max_connections = 100' > /home/$target_username/Inception/srcs/requirements/mariadb/conf/my.cnf

echo 'ALTER USER '\''root'\''@'\''localhost'\'' IDENTIFIED BY '\''${DB_ROOT}'\'';

CREATE DATABASE IF NOT EXISTS ${DB_NAME};
CREATE USER IF NOT EXISTS '\''${DB_USER}'\''@'\''%'\'' IDENTIFIED BY '\''${DB_PASSWORD}'\''; 
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '\''${DB_USER}'\''@'\''%'\''; 
FLUSH PRIVILEGES;' > /home/$target_username/Inception/srcs/requirements/mariadb/tools/initial_db.sql

echo 'FROM debian:bullseye

EXPOSE 80
EXPOSE 443

RUN mkdir -p /etc/nginx/ssl
RUN mkdir -p /run/nginx
RUN mkdir -p /etc/nginx/conf.d/

RUN apt-get update && apt-get install -y \
nginx \
openssl

COPY ../tools/ /etc/nginx/ssl/
COPY conf/nginx.conf /etc/nginx/conf.d/default.conf

CMD ["nginx", "-g", "daemon off;"]' > /home/$target_username/Inception/srcs/requirements/nginx/Dockerfile

echo 'server {

	listen 80;
	listen [::]:80;
	server_name $DOMAIN_NAME;
	return 301 https://$host$request_uri;
}

server {

	listen 443 ssl;
	listen [::]:443 ssl;
	
	server_name $DOMAIN_NAME www.$DOMAIN_NAME;
	
    ssl_certificate /etc/nginx/ssl/$DOMAIN_NAME.crt;
    ssl_certificate_key /etc/nginx/ssl/$DOMAIN_NAME.key;
	ssl_protocols TLSv1.2 TLSv1.3;

	root /var/www/;
	index index.php index.html index.htm;

    ssl_session_timeout 10m;
    keepalive_timeout 70;
    location / {
        try_files $uri /index.php?$args;
        add_header Last-Modified $date_gmt;
        add_header Cache-Control '\''no-store, no-cache'\'';
        if_modified_since off;
        expires off;
        etag off;
    }
	location ~ \.php$ {
    		fastcgi_split_path_info ^(.+\.php)(/.+)$;
    		fastcgi_pass wordpress:9000;
    		fastcgi_index index.php;
    		include fastcgi_params;
    		fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    		fastcgi_param PATH_INFO $fastcgi_path_info;
    	}

}' > /home/$target_username/Inception/srcs/requirements/nginx/conf/nginx.conf

echo 'RUN apt-get update && apt-get upgrade -y && \
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

CMD ["/usr/sbin/php-fpm${WP_PHP_VERSION}", "-F"]' > /home/$target_username/Inception/srcs/requirements/wordpress/Dockerfile

echo '#!/bin/sh
if [ ! -f "/var/www/wp-config.php" ]; then
    cat << '\''EOF'\'' > /var/www/wp-config.php
<?php
define( '\''DB_NAME'\'', '\''${DB_NAME}'\'' );
define( '\''DB_USER'\'', '\''${DB_USER}'\'' );
define( '\''DB_PASSWORD'\'', '\''${DB_PASSWORD}'\'' );
define( '\''DB_HOST'\'', '\''${DB_HOST}'\'' );
define( '\''DB_CHARSET'\'', '\''${DB_CHARSET}'\'' );
define( '\''DB_COLLATE'\'', '\''\'' );
\$table_prefix = '\''wp_'\'';
define( '\''WP_DEBUG'\'', false );
if ( ! defined( '\''ABSPATH'\'') ) {
    define( '\''ABSPATH'\'', __DIR__ . '\''/'\'' );
}
require_once ABSPATH . '\''wp-settings.php'\'';
EOF
fi' > /home/$target_username/Inception/srcs/requirements/wordpress/conf/wp-config-create.sh

if [ $? -eq 0 ]; then
    echo -e "${GREEN}11_fill_files.sh ended${NC}"
else
    echo -e "${RED}11_fill_files.sh failed. Script terminating.${NC}"
    exit 1
fi
