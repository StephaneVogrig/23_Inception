#!/bin/sh

set -e

# Function to log messages
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >&2
}

# Function to check if a variable is set and not empty
check_env_var() {
    local var_name="$1"
    local var_value="$2"
    
    if [ -z "$var_value" ]; then
        log "ERROR: Environment variable $var_name is not set or is empty"
        exit 1
    fi
}

# Database variables
check_env_var "WP_DB_HOST" "$WP_DB_HOST"
check_env_var "WP_DB_USER" "$WP_DB_USER"
check_env_var "WP_DB_PASSWORD" "$WP_DB_PASSWORD"
check_env_var "WP_DB_NAME" "$WP_DB_NAME"

# WordPress admin variables
check_env_var "WP_URL" "$WP_URL"
check_env_var "WP_TITLE" "$WP_TITLE"
check_env_var "WP_ADMIN" "$WP_ADMIN"
check_env_var "WP_ADMIN_PASS" "$WP_ADMIN_PASS"
check_env_var "WP_ADMIN_EMAIL" "$WP_ADMIN_EMAIL"

# WordPress user variables
check_env_var "WP_USER" "$WP_USER"
check_env_var "WP_PASS" "$WP_PASS"
check_env_var "WP_EMAIL" "$WP_EMAIL"

# Redis variables
check_env_var "REDIS_HOSTNAME" "$REDIS_HOSTNAME"
check_env_var "REDIS_PORT" "$REDIS_PORT"

log "Waiting for MariaDB to be ready..."
until nc -z -v -w3 mariadb 3306; do
	log "MariaDB is unavailable - sleeping"
	sleep 1
done

log "MariaDB is up - continuing"

if [ -f "/var/www/html/wp-config.php" ]; then
	log "WordPress already installed, skipping installation."
else
	log "wp-config.php not found. Installing and configuring wordpress..."

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
					--url=$WP_URL \
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
fi

log "Starting php-fpm..."
exec /usr/sbin/php-fpm83 -F
