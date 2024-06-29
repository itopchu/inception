#!/bin/bash

sleep 5

echo "Configuring MariaDB..."

if [ ! -d "/var/lib/mysql/$DB_NAME" ]; then

    service mariadb start || systemctl start mariadb

    sleep 1

    mysql_secure_installation <<EOF
Y
$DB_ROOT_PWD
$DB_ROOT_PWD
Y
Y
Y
Y
EOF

    echo "MariaDB configured"
    echo "Creating Database..."

    mysql -u root -p"$DB_ROOT_PWD" <<EOF
CREATE DATABASE IF NOT EXISTS $DB_NAME;
CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_USER_PWD';
GRANT ALL PRIVILEGES ON *.* TO '$DB_USER'@'%';
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PWD';
FLUSH PRIVILEGES;
EOF

    mysqladmin -u root -p"$DB_ROOT_PWD" shutdown
    
    echo "Database created"

fi

echo "Starting MariaDB..."

exec "$@"
