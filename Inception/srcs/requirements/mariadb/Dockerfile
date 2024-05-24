# base image for docker
FROM debian:bullseye

# mariadb-client is not needed if you are not planning to pass commands manually
RUN apt update && \
    apt install -y mariadb-server && \
    rm -rf /var/lib/apt/lists/*

# Set proper permissions for directories
RUN mkdir -p /var/run/mysqld && \
    chown -R mysql:mysql /var/run/mysqld && \
    chmod 777 /var/run/mysqld && \
    mkdir -p /var/lib/mysql && \
    chown -R mysql:mysql /var/lib/mysql && \
    chmod 777 /var/lib/mysql

# Port for connection
EXPOSE 3306

# Copy database settings
COPY conf/my.cnf /etc/mysql/my.cnf

# Copy the initialization script
COPY tools/configure.sh /tmp/
RUN chmod 777 /tmp/configure.sh

# Run the initialization script
ENTRYPOINT ["/tmp/configure.sh"]