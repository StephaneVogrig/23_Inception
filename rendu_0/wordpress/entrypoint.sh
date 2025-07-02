#!/bin/sh

set -e

# Function to log messages
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >&2
}

# Wait for MariaDB to be ready
log "Waiting for MariaDB to be ready..."
until nc -z -v -w3 mariadb 3306; do
	log "MariaDB is unavailable - sleeping"
	sleep 1
done
log "MariaDB is up - continuing"

# Install and configure wordpress if needed
if [ ! -f "/var/www/html/wp-config.php" ]; then
	log "wp-config.php not found. Installingand configuring wordpress..."

	log "Download WordPress core"
	wp --allow-root core download	--path="/var/www/html"

	log "Create config"
	wp --allow-root config create	--path="/var/www/html" \
						--dbname=$WP_DB_NAME \
						--dbuser=$WP_DB_USER \
						--dbpass=$WP_DB_PASSWORD \
						--dbhost=$WP_DB_HOST \
						--skip-check

	log "Install WordPress core"
	wp --allow-root core install	--path="/var/www/html" \
					--url=https://$WP_URL \
					--title=$WP_TITLE \
					--admin_user=$WP_ADMIN \
					--admin_password=$WP_ADMIN_PASS \
					--admin_email=$WP_ADMIN_EMAIL \
					--skip-email

	log "Create user"
	wp --allow-root user create	--path="/var/www/html" \
					$WP_USER $WP_EMAIL \
					--user_pass=$WP_PASS \
					--role='contributor'

	log "Installing redis-cache plugin"
	wp --allow-root config set WP_REDIS_HOST $REDIS_HOSTNAME
	wp --allow-root config set WP_REDIS_PORT $REDIS_PORT
	wp --allow-root config set WP_CACHE_KEY_SALT $WP_URL
	wp --allow-root plugin install redis-cache --activate
	wp --allow-root plugin update --all
	wp --allow-root redis enable
else
	log "WordPress already installed, skipping installation."
fi

log "Starting php-fpm..."
exec /usr/sbin/php-fpm83 -F
