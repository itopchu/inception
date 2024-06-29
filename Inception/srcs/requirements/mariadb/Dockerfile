FROM debian:bullseye

EXPOSE 3306

RUN apt-get update \
    && apt install -y mariadb-server

COPY tools/db-setup.sh /tmp/db-setup.sh

RUN chmod +x /tmp/db-setup.sh

ENTRYPOINT ["/tmp/config.sh"]

CMD ["mysqld", "--bind-address=0.0.0.0"]