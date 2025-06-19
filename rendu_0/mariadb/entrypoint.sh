#!/bin/sh

set -e

# Function to log messages
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >&2
}

if [ -d "/run/mysqld" ]; then
	log "mysqld exist, skippingcreation"
else
	log "mysqld not found, creating..."
	mkdir -p /run/mysqld
  chown -R mysql:mysql /run/mysqld
fi

# Initialization database
if [ ! -d "/var/lib/mysql/mysql" ]; then
  log "Database initialisation..."
  mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql > /dev/null

  mariadbd-safe --user=mysql --bootstrap <<-EOSQL
    CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
    CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
    GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
    ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
    FLUSH PRIVILEGES;
	EOSQL
fi

log "Starting MariaDB..."
exec mariadbd --user=mysql --console --skip-name-resolve --skip-networking=0 "$@"
