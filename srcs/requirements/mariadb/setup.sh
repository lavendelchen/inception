#!/bin/bash

# start mariadb so we can do the setup
( service mariadb start & ) | grep -q "Service is active" || true

# create all necessary users etc (if they haven't been created already)
mariadb -u root << EOF
CREATE DATABASE IF NOT EXISTS $DB_NAME;
CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO 'root'@'%' IDENTIFIED BY '$DB_PASS_ROOT';
SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$DB_PASS_ROOT');
EOF

# why???
sleep 5

# why???
( service mariadb stop & ) | grep -q "Service is inactive" || true

# run mysql/mariadb
exec $@