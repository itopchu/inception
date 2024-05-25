#!bin/sh

mysqld_safe &

mariadb -u root << EOF
CREATE DATABASE $DB_NAME;
CREATE USER $DB_USER@'%' IDENTIFIED BY '$DB_USER_PWD';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO $DB_USER@'%';
FLUSH PRIVILEGES;
EOF

mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PWD';"

mysqladmin -u root -p$DB_ROOT_PWD shutdown

mysqld_safe