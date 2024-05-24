#!/bin/bash

set -e

if [ ! -d "/var/lib/mysql/"$MYSQL_NAME"" ]; then
	mariadb-install-db --user=mysql

	echo "CREATE USER '$MYSQL_USR'@'%' IDENTIFIED BY '$MYSQL_PWD';" >> php_data.sql
	echo "GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_USR'@'%' WITH GRANT OPTION;" >> php_data.sql
	echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@localhost IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION;" >> php_data.sql
    # why the fuck named wordpress?
	echo "CREATE DATABASE IF NOT EXISTS wordpress;" >> php_data.sql
  	echo "FLUSH PRIVILEGES;" >> php_data.sql

	service mariadb start
	mariadb < php_data.sql
	service mariadb stop
fi

mariadbd --user=mysql
