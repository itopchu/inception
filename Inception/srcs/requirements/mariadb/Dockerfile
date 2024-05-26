FROM debian:bullseye

RUN apt update && \
    apt install -y mariadb-server

COPY conf/my.cnf /etc/mysql/my.cnf

COPY tools/db-setup.sh /docker-entrypoint-initdb.d/db-setup.sh

RUN chmod +x /docker-entrypoint-initdb.d/db-setup.sh

CMD ["mysqld"]