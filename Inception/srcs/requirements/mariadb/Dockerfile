# base image for docker
FROM debian:bullseye

# mariadb-client is not needed if you are not planning to pass commands manually
RUN apt update && \
    apt install -y mariadb-server

# Port for connection
EXPOSE 3306

# Copy script in executable path
COPY tools/configure.sh /tmp/
# Give execution permission
RUN chmod +x /tmp/configure.sh

# Copy database settings
COPY conf/50-server.cnf /etc/mysql/50-server.cnf

ENTRYPOINT [ "sh", "/tmp/configure.sh" ]