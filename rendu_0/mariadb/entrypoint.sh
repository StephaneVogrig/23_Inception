#!/bin/sh

set -e

# Function to log messages
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >&2
}

if [ -d "/run/mysqld" ]; then
	log "mysqld exist, skipping creation"
else
	log "mysqld not found, creating..."
	mkdir -p /run/mysqld
  chown -R mysql:mysql /run/mysqld
fi

# Initialization database
if [ ! -d "/var/lib/mysql/mysql" ]; then

  log "Database initialisation..."

  log "Initialize the data directory"
  mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql > /dev/null

  log "Start MariaDB temporarily in the background for initialization"
  # Use --skip-networking to avoid external connections during setup
  # Use --skip-name-resolve for faster startup
  mariadbd --user=mysql --skip-networking --skip-name-resolve --socket=/run/mysqld/mysqld.sock &
  MYSQL_PID=$!

  log "Wait for MariaDB to be ready"
  for i in $(seq 1 30); do
    /usr/bin/mariadb-admin ping -hlocalhost --silent && break
    log "Waiting for mariadb to be up ($i/30)..."
    sleep 1
  done

  if ! /usr/bin/mariadb-admin ping -hlocalhost --silent; then
    log "MariaDB did not come up, exiting."
    exit 1
  fi

  log "Mariadb ready"

  log "Execute SQL commands"
  mariadb -hlocalhost <<-EOSQL
    DROP DATABASE IF EXISTS test;
    CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
    CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
    GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
    ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
    FLUSH PRIVILEGES;
	EOSQL

  # Shut down the temporary MariaDB instance
  log "Shutting down temporary MariaDB instance..."
  kill ${MYSQL_PID}
  wait ${MYSQL_PID} || true # Wait for the process to exit, ignore errors if it's already gone

fi

log "Starting MariaDB..."
exec mariadbd --user=mysql --console --skip-name-resolve --skip-networking=0 "$@"
