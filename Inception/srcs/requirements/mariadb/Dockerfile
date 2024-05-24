# base image for docker
FROM debian:bullseye

# mariadb-client is not needed if you are not planning to pass commands manually
RUN apt update && \
    apt install -y mariadb-server mariadb-client && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Port for connection
EXPOSE 3306

# Create and allow UNIX socket folder
RUN mkdir -p /var/run/mysqld && \
	chmod 755 /var/run/mysqld

# Copy script in executable path
COPY tools/configure.sh /usr/local/bin/

# Give execution permission
RUN chmod +x /usr/local/bin/configure.sh

# Copy database settings
COPY conf/my.cnf /etc/mysql/my.cnf

USER mysql

ENTRYPOINT [ "sh", "/usr/local/bin/configure.sh" ]