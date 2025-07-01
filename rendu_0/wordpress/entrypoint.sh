#!/bin/sh

set -e

# Function to log messages
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >&2
}

# # Wait for MariaDB to be ready
# log "Waiting for MariaDB to be ready..."
# until nc -z -v -w3 mariadb 3306; do
# 	log "MariaDB is unavailable - sleeping"
# 	sleep 5
# done
# log "MariaDB is up - continuing"

# Install and configure wordpress if needed
if [ ! -f "/var/www/html/wp-config.php" ]; then
	sleep 30
	log "wp-config.php not found. Installingand configuring wordpress..."

	log "Download WordPress core"
	wp core download	--path="/var/www/html" \
						--allow-root

	log "Create config"
	wp config create	--path="/var/www/html" \
						--allow-root \
						--dbname=$WP_DB_NAME \
						--dbuser=$WP_DB_USER \
						--dbpass=$WP_DB_PASSWORD \
						--dbhost=$WP_DB_HOST \
						--skip-check

	log "Install WordPress core"
	wp core install	--path="/var/www/html" \
					--allow-root \
					--url=$WP_URL \
					--title=$WP_TITLE \
					--admin_user=$WP_ADMIN \
					--admin_password=$WP_ADMIN_PASS \
					--admin_email=$WP_ADMIN_EMAIL \
					--skip-email

	log "Create user"
	wp user create	--path="/var/www/html" \
					--allow-root $WP_USER $WP_EMAIL \
					--user_pass=$WP_PASS \
					--role='contributor'
else
	log "WordPress already installed, skipping installation."
fi

log "Starting php-fpm..."
# exec /usr/sbin/php-fpm${PHP_VERSION} -F
exec /usr/sbin/php-fpm7.4 -F
