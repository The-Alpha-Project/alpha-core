#!/bin/sh
set -e

SSL_ARGS=""
case "${MYSQL_SSL_MODE:-DISABLED}" in
    DISABLED|disabled|0|false|FALSE|"") SSL_ARGS="--skip-ssl" ;;
    REQUIRED|required|1|true|TRUE) SSL_ARGS="--ssl" ;;
esac

DB_HOST="${DB_HOST:-$MYSQL_HOST}"
DB_PORT="${DB_PORT:-$MYSQL_PORT}"
DB_HOST="${DB_HOST}"

SKIP_CREATE=0
case "${DB_SKIP_CREATE:-false}" in
    1|true|TRUE|yes|YES) SKIP_CREATE=1 ;;
esac

if [ "$SKIP_CREATE" -eq 1 ] && [ -n "${EXTERNAL_DB_HOST:-}" ] && [ "$MYSQL_HOST" = "$EXTERNAL_DB_HOST" ]; then
    echo "Skipping DB user creation (external DB + DB_SKIP_CREATE)."
    exit 0
fi

ADMIN_USER="${MYSQL_ADMIN_USERNAME:-$MYSQL_USERNAME}"
ADMIN_PASS="${MYSQL_ADMIN_PASSWORD:-$MYSQL_PASSWORD}"

if [ -z "$MYSQL_USERNAME" ] || [ -z "$MYSQL_PASSWORD" ]; then
    echo "MYSQL_USERNAME/MYSQL_PASSWORD not set."
    exit 1
fi

if [ "$MYSQL_USERNAME" = "root" ]; then
    echo "MYSQL_USERNAME is root; skipping user creation."
    exit 0
fi

SQL="DROP USER IF EXISTS '$MYSQL_USERNAME'@'%';
CREATE USER '$MYSQL_USERNAME'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"

echo "Creating DB user '$MYSQL_USERNAME'..."
echo "$SQL" | mariadb -h "$DB_HOST" -P "$DB_PORT" -u "$ADMIN_USER" -p"$ADMIN_PASS" $SSL_ARGS
echo "DB user created."
