FROM debian:bullseye

RUN apt update && \
    apt install -y mariadb-server

EXPOSE 3306

RUN mkdir -p /var/run/mysqld && \
	chmod 777 /var/run/mysqld

COPY conf/my.cnf /etc/mysql/my.cnf

COPY tools/configure.sh /tmp/

RUN chmod +x /tmp/configure.sh

CMD ["/tmp/configure.sh"]