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

check_env_var "FTP_USER" "$FTP_USER"
check_env_var "FTP_PASSWORD" "$FTP_PASSWORD"

WORKDONE_FILE=/etc/vsftpd.ok


if [ -f "$WORKDONE_FILE" ]; then
	log "vsftpd already setup, skipping"
else
	log "Creating vsftpd user"

	adduser $FTP_USER --disabled-password
    echo "$FTP_USER:$FTP_PASSWORD" | /usr/sbin/chpasswd &>/dev/null

	log "Giving vsftpd user ownership of WordPress data directory"
    chown -R "$FTP_USER:$FTP_USER" /var/www/html

	echo $FTP_USER >> /etc/vsftpd.userlist

	touch $WORKDONE_FILE
fi

mkdir /var/run/vsftpd/empty -p

log "Starting vsftpd"
exec vsftpd /etc/vsftpd.conf
