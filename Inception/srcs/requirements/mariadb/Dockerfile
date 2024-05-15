# base image for docker
FROM debian:bullseye

# Port for https connection
EXPOSE 3306

# gettext-base is needed for env expasion
# mariadb-client is not needed if you are not planning to pass commands manually
RUN apt-get update \
    && apt-get install -y mariadb-server mariadb-client gettext-base \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ARG MYSQL_ROOT_PASSWORD
ARG MYSQL_DATABASE
ARG MYSQL_USER
ARG MYSQL_PASSWORD

# Variable expansion in config file
COPY ./conf/configure.sql /tmp/configure.sql.template
RUN envsubst '$MYSQL_ROOT_PASSWORD $MYSQL_DATABASE $MYSQL_USER $MYSQL_PASSWORD' \
    < /tmp/configure.sql.template > /tmp/configure.sql && \
    rm -f /tmp/configure.sql.template

# Entry point for out image
COPY ./tools/configure.sh /tmp/configure.sh

ENTRYPOINT [ "sh", "/tmp/configure.sh" ]