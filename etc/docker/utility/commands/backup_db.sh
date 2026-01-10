#!/bin/sh
set -e

BASE_BACKUP_DIR="/var/wow/etc/databases/backup"
SSL_ARGS=""
case "${MYSQL_SSL_MODE:-DISABLED}" in
    DISABLED|disabled|0|false|FALSE|"") SSL_ARGS="--skip-ssl" ;;
    REQUIRED|required|1|true|TRUE) SSL_ARGS="--ssl" ;;
esac
DB_HOST="${DB_HOST:-$MYSQL_HOST}"
DB_PORT="${DB_PORT:-$MYSQL_PORT}"
DB_HOST="${DB_HOST}"
DB_PREFIX="${DB_PREFIX:-alpha_}"

. /bin/commands/wait_for_db.sh
wait_for_db

DATE=$(date +"%Y%m%d_%H%M%S")
BACKUP_DIR="${BASE_BACKUP_DIR}/${PROJECT_NAME}_${DATE}"

mkdir -p "$BACKUP_DIR"

echo "Backing up ${PROJECT_NAME} databases (prefix '${DB_PREFIX}')..."

for DB in "${DB_PREFIX}auth" "${DB_PREFIX}world" "${DB_PREFIX}dbc" "${DB_PREFIX}realm"; do
    echo "Dumping $DB..."
    mysqldump \
        -h "$DB_HOST" \
        -P "$DB_PORT" \
        -u "$MYSQL_USERNAME" \
        -p"$MYSQL_PASSWORD" \
        $SSL_ARGS \
        "$DB" > "$BACKUP_DIR/$DB.sql"
done

echo "Backups stored in: $BACKUP_DIR"
