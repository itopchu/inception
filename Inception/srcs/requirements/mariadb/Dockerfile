FROM debian:bullseye

RUN apt-get update && apt-get install -y mariadb-server

ENV MYSQL_ROOT_PASSWORD=root_password
ENV MYSQL_DATABASE=wordpress_db
ENV MYSQL_USER=wordpress_user
ENV MYSQL_PASSWORD=wordpress_password

# COPY ../conf/init.sql /etc/$HOME/init.cnf
COPY ../conf/my.cnf /etc/$HOME/my.cnf

EXPOSE 3306