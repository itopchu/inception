#!/bin/sh

# Ensure /run/mysqld exists
if [ ! -d "/run/mysqld" ]; then
    mkdir -p /run/mysqld
    chown -R mysql:mysql /run/mysqld
fi

# Initialize the MySQL database
if [ ! -d "/var/lib/mysql/mysql" ]; then
    chown -R mysql:mysql /var/lib/mysql
    # init database
    mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql > /dev/null
fi

# Start the MySQL server
/usr/bin/mysqld_safe --skip-networking &
mysql_pid="$!"

# Wait for MySQL to start
while ! mysqladmin ping -h127.0.0.1 --silent; do
    sleep 1
done

# Execute SQL commands to configure the MySQL database
mysql -uroot -p "$MYSQL_ROOT_PASSWORD" < /tmp/configure.sql


# Allow remote connections
sed -i "s|skip-networking|# skip-networking|g" /etc/mysql/mariadb.conf.d/50-server.cnf
sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/mysql/mariadb.conf.d/50-server.cnf

# Start the MySQL server
kill "$mysql_pid"
/usr/sbin/mysqld --user=mysql --console