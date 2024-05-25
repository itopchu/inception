FROM debian:bullseye

RUN apt update && \
    apt install -y mariadb-server

COPY tools/configure.sh /tmp/

COPY conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf

RUN chmod +x /tmp/database.sh

CMD ["./tmp/database.sh"]