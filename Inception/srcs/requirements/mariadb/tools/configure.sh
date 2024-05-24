#!/bin/sh

# Start the MariaDB server
mysqld_safe &

# Set the root password and create the database and user
mariadb -u root <<EOF
CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
CREATE USER IF NOT EXISTS '$MYSQL_USR'@'%' IDENTIFIED BY '$MYSQL_PWD';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '$MYSQL_USR'@'%';
FLUSH PRIVILEGES;
EOF

# Alter the root user password
mariadb -u root <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
FLUSH PRIVILEGES;
EOF

# Shut down the MariaDB server
mysqladmin -u root -p$MYSQL_ROOT_PASSWORD shutdown

# Start the MariaDB server in the foreground
exec mysqld_safe