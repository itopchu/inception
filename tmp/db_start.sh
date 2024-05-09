#!/bin/bash

sed -i "s|\\${DB_ROOT}|$DB_ROOT|g" /var/www/initial_db.sql
sed -i "s|\\${DB_NAME}|$DB_NAME|g" /var/www/initial_db.sql
sed -i "s|\\${DB_USER}|$DB_USER|g" /var/www/initial_db.sql
sed -i "s|\\${DB_PASSWORD}|$DB_PASSWORD|g" /var/www/initial_db.sql

service mariadb start

mysql < /var/www/initial_db.sql

rm -f /var/www/initial_db.sql

rm -f "$0"

exec mysqld