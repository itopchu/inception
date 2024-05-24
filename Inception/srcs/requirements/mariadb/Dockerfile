# base image for docker
FROM debian:bullseye

# mariadb-client is not needed if you are not planning to pass commands manually
RUN apt update && \
    apt install -y mariadb-server

RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

# Port for connection
EXPOSE 3306

# Copy database settings
COPY conf/50-server.cnf /etc/mysql/50-server.cnf

# Copy the initialization script
COPY tools/configure.sh /tmp/
RUN chmod +x /tmp/configure.sh

# Run the initialization script
ENTRYPOINT ["/tmp/configure.sh"]