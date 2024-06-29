FROM debian:bullseye

EXPOSE 3306

RUN apt-get update && apt-get install -y \
	mariadb-server

COPY ./tools/config.sh /tmp/

RUN chmod +x /tmp/config.sh

ENTRYPOINT ["/tmp/config.sh"]

CMD ["mysqld", "--bind-address=0.0.0.0"]
