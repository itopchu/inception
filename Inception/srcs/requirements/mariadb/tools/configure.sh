#!/bin/sh

# Incase of any error exit script immediately
set -e

# Check if given database already exists
if [ ! -d "/var/lib/mysql/"$MYSQL_DATABASE ]; then
    # Create necessary tables and specify user
	mariadb-install-db --user=mysql

    # Write settings into temporary file

    echo "CREATE DATABASE IF NOT EXISTS '$MYSQL_DATABASE';" > tmp.sql

    # Create a MySQL user with the provided username and password, allowing connections from any host ('%')
	echo "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" >> tmp.sql

    # Grant all privileges on all databases to the newly created user, allowing them to grant privileges to other users
	echo "GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_USER'@'%' WITH GRANT OPTION;" >> tmp.sql

    # Grant all privileges on all databases to the root user, allowing them to grant privileges to other users
	echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@localhost IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION;" >> tmp.sql

    # Create a new database named 'wordpress' if it doesn't already exist
    echo "CREATE DATABASE IF NOT EXISTS wordpress;" >> tmp.sql

    # Flush the MySQL privileges to apply the changes made by the GRANT statements
  	echo "FLUSH PRIVILEGES;" >> tmp.sql

    # Execute SQL commands using MariaDB client
	mariadb < tmp.sql

    # Remove temporary file
    rm -f tmp.sql
fi

# Start MariaDB server daemon
mariadbd --user=mysql