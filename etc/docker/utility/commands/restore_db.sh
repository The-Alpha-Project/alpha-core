#!/bin/sh
set -e

echo "=== Restoring ${PROJECT_NAME} databases ==="

BACKUP_DIR="/var/wow/etc/databases/backup"
DB_HOST="${DB_HOST:?DB_HOST not set}"
DB_PORT="${DB_PORT:?DB_PORT not set}"
ROOT_USER="${MYSQL_USERNAME:?MYSQL_USERNAME not set}"
ROOT_PASS="${MYSQL_PASSWORD:?MYSQL_PASSWORD not set}"
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

# Set DB names
DATABASES="${DB_PREFIX}auth ${DB_PREFIX}world ${DB_PREFIX}dbc ${DB_PREFIX}realm"

# Use provided backup folder or auto-detect latest
if [ -n "$BACKUP" ]; then
    BACKUP_PATH="$BACKUP_DIR/$BACKUP"
else
    LATEST_BACKUP=$(ls -1 "$BACKUP_DIR" | sort | tail -n 1)
    BACKUP_PATH="$BACKUP_DIR/$LATEST_BACKUP"
fi

if [ ! -d "$BACKUP_PATH" ]; then
    echo "Backup directory $BACKUP_PATH not found."
    exit 1
fi

echo "Using backup: $BACKUP_PATH"

reset_db() {
    local db="$1"
    echo "Resetting database $db..."
    mariadb -h "$DB_HOST" -P "$DB_PORT" -u "$ROOT_USER" -p"$ROOT_PASS" $SSL_ARGS -e \
        "DROP DATABASE IF EXISTS \`$db\`; CREATE DATABASE \`$db\` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;"
}

for DB in $DATABASES; do
    DUMP_FILE="$BACKUP_PATH/${DB}.sql"
    reset_db "$DB"
    if [ -f "$DUMP_FILE" ]; then
        echo "Restoring $DB from $DUMP_FILE..."
        mariadb -h "$DB_HOST" -P "$DB_PORT" -u "$ROOT_USER" -p"$ROOT_PASS" $SSL_ARGS "$DB" < "$DUMP_FILE"
        echo "Restored $DB successfully."
    else
        echo "Warning: No dump file for $DB at $DUMP_FILE"
    fi
done

echo "=== Database restore complete ==="
