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

# set -e

# # Function to log messages
# log() {
#     echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >&2
# }

# # Wait for MariaDB to be ready
# log "Waiting for MariaDB to be ready..."
# until nc -z -v -w3 mariadb 3306; do
# 	log "MariaDB is unavailable - sleeping"
# 	sleep 5
# done
# log "MariaDB is up - continuing"

# # Configure wp-config.php
# if [ -f "/var/www/html/wp-config.php" ]; then
# 	log "wp-config.php already exists. Skipping configuration."
# else
# 	log "wp-config.php not found. Creating from wp-config-sample.php..."

#     cd /var/www/html

# 	cp wp-config-sample.php wp-config.php

#     # Replace database connection details
#     sed -i "s/define( 'DB_NAME', 'database_name_here' );/define( 'DB_NAME', '$WP_DB_NAME' );/" wp-config.php
#     sed -i "s/define( 'DB_USER', 'username_here' );/define( 'DB_USER', '$WP_DB_USER' );/" wp-config.php
#     sed -i "s/define( 'DB_PASSWORD', 'password_here' );/define( 'DB_PASSWORD', '$WP_DB_PASSWORD' );/" wp-config.php
#     sed -i "s/define( 'DB_HOST', 'localhost' );/define( 'DB_HOST', '$WP_DB_HOST' );/" wp-config.php

#     log "wp-config.php created."
# fi

# # Install WordPress core (only if it's a fresh setup)
# if ! wp core is-installed --allow-root 2>/dev/null; then
#     log "WordPress not installed. Running wp core install..."
#     wp core install \
#         --url="https://svogrig.42.fr:42443" \
#         --title="Mon Inception WordPress" \
#         --admin_user="${WORDPRESS_ADMIN_USER:-admin}" \
#         --admin_password="${WORDPRESS_ADMIN_PASSWORD:-password}" \
#         --admin_email="${WORDPRESS_ADMIN_EMAIL:-admin@example.com}" \
#         --skip-email \
#         --allow-root

#     log "WordPress core installed."
# else
#     log "WordPress core already installed."
# fi

# log "Starting php-fpm..."
# exec /usr/sbin/php-fpm${PHP_VERSION} -F

#!/bin/sh

set -e

if [ ! -f "/var/www/html/wp-config.php" ]
then
	sleep 30
	wp core download --path="/var/www/html" --allow-root
	wp config create --path="/var/www/html" --allow-root --dbname=$WP_DB_NAME --dbuser=$WP_DB_USER --dbpass=$WP_DB_PASSWORD --dbhost=$WP_DB_HOST --skip-check
	wp core install --path="/var/www/html" --allow-root --url=$WP_URL --title=$WP_TITLE --admin_user=$WP_ADMIN --admin_password=$WP_ADMIN_PASS --admin_email=$WP_ADMIN_EMAIL --skip-email
	wp user create --path="/var/www/html" --allow-root $WP_USER $WP_EMAIL --user_pass=$WP_PASS --role='contributor'
else
	echo "WordPress already installed, skipping installation."
fi

echo "Starting PHP-FPM..."
exec /usr/sbin/php-fpm7.4 -F
