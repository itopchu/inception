FROM debian:bullseye

EXPOSE 3306

RUN apt-get update && apt-get install -y mariadb-server

COPY ./conf/ /etc/mysql/mariadb.conf.d/
COPY ./tools /var/www/

RUN service mysql start && mysql < /var/www/initial_db.sql && rm -f /var/www/initial_db.sql;

CMD ["mysqld"]