FROM    debian:bullseye

RUN     apt-get update -yq \
        && apt-get upgrade -y
		&& apt-get install mariadb-server mariadb-client -y
        && mkdir -p /var/run/mysqld
		&& chown -R mysql:mysql /var/run/mysqld /etc/mysql
		&& chown -R mysql:mysql /tmp/ /etc/mysql/

COPY    ./tools/run.sh /tmp/
COPY    ./conf/init.sql /tmp/
COPY    ./conf/my.cnf /etc/mysql

EXPOSE  3306

USER	mysql

ENTRYPOINT ["sh", "/tmp/run.sh"]