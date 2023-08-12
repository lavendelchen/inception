#!/bin/bash

set -ex

sleep 3

# download wordpress
wp --allow-root --path="/var/www/inception" core download || true
# install wordpress
if ! wp --allow-root --path=/var/www/inception core is-installed;
then
    wp  --allow-root --path="/var/www/inception" core install \
        --url=$WP_URL \
        --title=$WP_TITLE \
        --admin_user=$WP_ADMIN_USER \
        --admin_password=$WP_ADMIN_PASSWORD \
        --admin_email=$WP_ADMIN_EMAIL
fi;
# make wordpress user
if ! wp --allow-root --path=/var/www/inception user get $WP_USER;
then
    wp  --allow-root --path="/var/www/inception" user create \
        $WP_USER \
        $WP_EMAIL \
        --user_pass=$WP_PASSWORD \
        --role=$WP_ROLE
fi;

exec $@