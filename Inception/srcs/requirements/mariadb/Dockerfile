FROM debian:bullseye

EXPOSE 3306

RUN apt-get update && apt-get install -y \
	mariadb-server

COPY ./tools/db-config.sh /tmp/

RUN chmod +x /tmp/db-config.sh

ENTRYPOINT ["/tmp/db-config.sh"]

CMD ["mysqld", "--bind-address=0.0.0.0"]
