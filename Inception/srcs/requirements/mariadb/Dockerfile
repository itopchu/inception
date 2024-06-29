FROM debian:bullseye

EXPOSE 3306

RUN apt-get update \
    && apt install -y mariadb-server

COPY tools/db-setup.sh /docker-entrypoint-initdb.d/db-setup.sh

RUN chmod +x /docker-entrypoint-initdb.d/db-setup.sh


CMD ["mysqld", "--bind-address=0.0.0.0"]