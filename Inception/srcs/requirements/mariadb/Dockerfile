# base image for docker
FROM debian:bullseye

# Port for https connection
EXPOSE 3306

# gettext-base is needed for env expasion
# mariadb-client is not needed if you are not planning to pass commands manually
RUN apt-get update \
    && apt-get install -y mariadb-server gettext-base \
    && mariadb-server mariadb-client \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Variable expansion in config file
COPY ./tools/initial.sql /var/www/initial.sql.template
RUN envsubst '$MYSQL_ROOT_PASSWORD $MYSQL_DATABASE $MYSQL_USER $MYSQL_PASSWORD' < /var/www/initial.sql.template > /var/www/initial.sql

RUN service mysql start \
    && mysql < /var/www/initial.sql \
    && rm -f /var/www/initial.sql \
    && rm -f /var/www/initial.sql.template

# Start MariaDB Server
CMD ["mysqld_safe"]