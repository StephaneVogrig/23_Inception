#!/bin/sh

# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    entrypoint.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: svogrig <svogrig@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/06/19 12:47:41 by svogrig           #+#    #+#              #
#    Updated: 2025/06/19 15:52:31 by svogrig          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

set -e

# Function to log messages
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >&2
}

# Wait for MariaDB to be ready
log "Waiting for MariaDB to be ready..."
until nc -z -v -w3 mariadb 3306; do
	log "MariaDB is unavailable - sleeping"
	sleep 5
done
log "MariaDB is up - continuing"

# Configure wp-config.php
if [ -f "/var/www/html/wp-config.php" ]; then
	log "wp-config.php already exists. Skipping configuration."
else
	log "wp-config.php not found. Creating from wp-config-sample.php..."

	cp wp-config-sample.php wp-config.php

        # Replace database connection details
        sed -i "s/define( 'DB_NAME', 'database_name_here' );/define( 'DB_NAME', '$WORDPRESS_DB_NAME' );/" wp-config.php
        sed -i "s/define( 'DB_USER', 'username_here' );/define( 'DB_USER', '$WORDPRESS_DB_USER' );/" wp-config.php
        sed -i "s/define( 'DB_PASSWORD', 'password_here' );/define( 'DB_PASSWORD', '$WORDPRESS_DB_PASSWORD' );/" wp-config.php
        sed -i "s/define( 'DB_HOST', 'localhost' );/define( 'DB_HOST', '$WORDPRESS_DB_HOST' );/" wp-config.php
fi

log "Starting php-fpm..."
exec /usr/sbin/php-fpm${PHP_VERSION} -F
