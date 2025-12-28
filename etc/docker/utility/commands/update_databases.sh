#!/bin/sh
set -e

BASE_DIR="/var/wow/etc/databases"
SCHEMAS="auth dbc realm world"
SSL_ARGS=""
case "${MYSQL_SSL_MODE:-DISABLED}" in
    DISABLED|disabled|0|false|FALSE|"") SSL_ARGS="--skip-ssl" ;;
    REQUIRED|required|1|true|TRUE) SSL_ARGS="--ssl" ;;
esac
DB_HOST="${DB_HOST:-$MYSQL_HOST}"
DB_PORT="${DB_PORT:-$MYSQL_PORT}"
DB_HOST="${DB_HOST}"
DB_PREFIX="${DB_PREFIX:-alpha_}"

for DB in $SCHEMAS; do
    UPDATE_SQL="$BASE_DIR/$DB/updates/updates.sql"

    if [ -f "$UPDATE_SQL" ]; then
        DB_NAME="${DB_PREFIX}${DB}"
        echo "Updating $DB_NAME..."
        mariadb --force -h "$DB_HOST" -P "$DB_PORT" -u "$MYSQL_USERNAME" -p"$MYSQL_PASSWORD" $SSL_ARGS "$DB_NAME" < "$UPDATE_SQL"
        echo "$DB_NAME updated."
    else
        echo "Skipping $DB (no updates.sql)."
    fi
done
