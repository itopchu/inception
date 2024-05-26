FROM debian:bullseye

RUN apt update \
    && apt install -y mariadb-server \
    && mkdir -p /var/run/mysqld \
    && chown -R mysql:mysql /var/run/mysqld

COPY conf/my.cnf /etc/mysql/my.cnf

COPY tools/db-setup.sh /docker-entrypoint-initdb.d/db-setup.sh

RUN chmod +x /docker-entrypoint-initdb.d/db-setup.sh

CMD ["mysqld"]