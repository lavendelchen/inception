#!/bin/bash

# For debugging and stuff
set -ex

# Start mariadb so we can do the setup
( service mariadb start & ) | grep -q "Service is active" || true #??

sleep 3

service mariadb status

# Create all necessary users etc (if they haven't been created already)
mariadb -v -u root << EOF
CREATE DATABASE IF NOT EXISTS $DB_NAME;
CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO 'root'@'%' IDENTIFIED BY '$DB_PASS_ROOT';
SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$DB_PASS_ROOT');
EOF

sleep 5

# stop mariadb
( service mariadb stop & ) | grep -q "Service is inactive" || true

# Run mysql/mariadb
exec $@