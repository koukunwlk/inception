#!/bin/bash

export WP_CLI_CACHE_DIR="/var/www/html/.wp-cli/cache"

wp core download --path=/var/www/html --force --allow-root;

service mariadb start;

wp core config \
    --dbname="$MARIADB_DATABASE" \
    --dbuser="$MARIADB_USER" \
    --dbpass="$MARIADB_PASSWORD" \
    --dbhost="$MARIADB_ROOT_HOST" \
    --allow-root;

wp core install --url=$DOMAIN \
    --title="$WP_TITLE" \
    --admin_user=$WP_ADMIN_USR \
    --admin_password=$WP_ADMIN_PWD \
    --admin_email=$WP_ADMIN_EMAIL \
    --allow-root;
# Create a new user
wp user create "$WP_USR" "$WP_EMAIL" --user_pass="$WP_PWD" --role=subscriber --allow-root;

# Start PHP-FPM
/usr/sbin/php-fpm7.4 --nodaemonize;
