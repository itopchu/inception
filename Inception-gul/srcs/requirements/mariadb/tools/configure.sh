#!/bin/bash

set -e

if [ ! -d "/var/lib/mysql/$DB_NAME" ]; then
	echo "Mariadb is starting"
	mariadb-install-db --user=mysql
	
	echo "CREATE USER '$DB_USER'@'%' IDENTIFIED BY '$DB_USER_PWD';" >> /tmp/php_data.sql
	echo "GRANT ALL PRIVILEGES ON *.* TO '$DB_USER'@'%' WITH GRANT OPTION;" >> /tmp/php_data.sql
	echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@localhost IDENTIFIED BY '$DB_ROOT_PWD' WITH GRANT OPTION;" >> /tmp/php_data.sql
	echo "CREATE DATABASE IF NOT EXISTS wordpress;" >> /tmp/php_data.sql
  	echo "FLUSH PRIVILEGES;" >> /tmp/php_data.sql

	service mariadb start
	mariadb < /tmp/php_data.sql
	service mariadb stop

	rm /tmp/php_data.sql
else
	echo "MariaDB is already initialized."
fi

mariadbd --user=mysql
