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

# Configure the MySQL database
chmod +x /tmp/configure_database.sh
/tmp/configure_database.sh

# Allow remote connections
sed -i "s|skip-networking|# skip-networking|g" /etc/mysql/mariadb.conf.d/50-server.cnf
sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/mysql/mariadb.conf.d/50-server.cnf

# Start the MySQL server
exec /usr/sbin/mysqld --user=mysql --console