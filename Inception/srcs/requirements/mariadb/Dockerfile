# base image for docker
FROM debian:bullseye

# mariadb-client is not needed if you are not planning to pass commands manually
RUN apt update && \
    apt install -y mariadb-server

# Port for connection
EXPOSE 3306

RUN mkdir -p /var/run/mysqld && \
	chmod 777 /var/run/mysqld

# Copy database settings
COPY conf/my.cnf /etc/mysql/my.cnf

# Copy the initialization script
COPY tools/configure.sh /tmp/
RUN chmod +x /tmp/configure.sh

# Run the initialization script
ENTRYPOINT ["/tmp/configure.sh"]