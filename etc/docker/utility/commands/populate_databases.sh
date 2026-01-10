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

. /bin/commands/wait_for_db.sh
wait_for_db

SKIP_CREATE=0
case "${DB_SKIP_CREATE:-false}" in
    1|true|TRUE|yes|YES) SKIP_CREATE=1 ;;
esac

if [ "$SKIP_CREATE" -eq 1 ] && [ -n "${EXTERNAL_DB_HOST:-}" ] && [ "$MYSQL_HOST" = "$EXTERNAL_DB_HOST" ]; then
    echo "Skipping populate (external DB + DB_SKIP_CREATE)."
    exit 0
fi
DB_PREFIX="${DB_PREFIX:-alpha_}"

for DB in $SCHEMAS; do
    SCHEMA_SQL="$BASE_DIR/$DB/$DB.sql"
    DB_NAME="${DB_PREFIX}${DB}"
    echo "Populating $DB_NAME..."
    mariadb --force -h "$DB_HOST" -P "$DB_PORT" -u "$MYSQL_USERNAME" -p"$MYSQL_PASSWORD" $SSL_ARGS "$DB_NAME" < "$SCHEMA_SQL"
    echo "  └─ Schema imported."

    echo "$DB_NAME populated."
done
