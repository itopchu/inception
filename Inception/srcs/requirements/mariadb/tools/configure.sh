#!/bin/bash

# Initialize the database if it doesn't exist
if [ ! -d "/var/lib/mysql/mysql" ]; then

    # Start MariaDB service
    service mysql start

    # Set root password
    mysqladmin -u root password "${MYSQL_ROOT_PASSWORD}"

    # Remove the temporary password for root user
    mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"

    # Remove anonymous users and disallow remote root login
    mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "DELETE FROM mysql.user WHERE User='';"
    mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');"
    mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "DROP DATABASE IF EXISTS test;"
    mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "DELETE FROM mysql.db WHERE Db='test';"

    # Stop MariaDB service
    service mysql stop
fi

# Create the WordPress database and user if not already created
if [ ! -d "/var/lib/mysql/$MYSQL_NAME" ]; then

    # Start MariaDB service
    service mysql start

    cat << EOF > /tmp/create_db.sql
USE mysql;
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS ${MYSQL_NAME} CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER IF NOT EXISTS '${MYSQL_USR}'@'%' IDENTIFIED BY '${MYSQL_PWD}';
GRANT ALL PRIVILEGES ON ${MYSQL_NAME}.* TO '${MYSQL_USR}'@'%';
FLUSH PRIVILEGES;

USE ${MYSQL_NAME};

-- Create the administrator user
INSERT INTO wp_users (user_login, user_pass, user_nicename, user_email, user_status)
VALUES ('${WP_ADMIN_USR}', MD5('${WP_ADMIN_PWD}'), 'Admin User', '${WP_ADMIN_EMAIL}', 0)
ON DUPLICATE KEY UPDATE user_pass = MD5('${WP_ADMIN_PWD}'), user_email = '${WP_ADMIN_EMAIL}';
INSERT INTO wp_usermeta (user_id, meta_key, meta_value)
SELECT ID, 'wp_capabilities', 'a:1:{s:13:"administrator";s:1:"1";}' FROM wp_users WHERE user_login = '${WP_ADMIN_USR}';

-- Create the second user
INSERT INTO wp_users (user_login, user_pass, user_nicename, user_email, user_status)
VALUES ('${WP_USR}', MD5('${WP_PWD}'), 'Second User', '${WP_EMAIL}', 0)
ON DUPLICATE KEY UPDATE user_pass = MD5('${WP_PWD}'), user_email = '${WP_EMAIL}';
INSERT INTO wp_usermeta (user_id, meta_key, meta_value)
SELECT ID, 'wp_capabilities', 'a:1:{s:10:"subscriber";s:1:"1";}' FROM wp_users WHERE user_login = '${WP_USR}';

EOF

    # Run the SQL script to initialize the database
    mysql --defaults-file=/etc/mysql/my.cnf --user=root --password="${MYSQL_ROOT_PASSWORD}" < /tmp/create_db.sql
    rm -f /tmp/create_db.sql

    # Stop MariaDB service
    service mysql stop
fi

# Start the MariaDB service normally
exec mysqld --defaults-file=/etc/mysql/my.cnf --user=mysql --console