#!/bin/sh
set -e

# Default prefix for db names.
DB_PREFIX="${DB_PREFIX:-alpha_}"
DB_AUTH_NAME="${DB_PREFIX}auth"
DB_REALM_NAME="${DB_PREFIX}realm"
DB_WORLD_NAME="${DB_PREFIX}world"
DB_DBC_NAME="${DB_PREFIX}dbc"
ADMIN_USER="${MYSQL_ADMIN_USERNAME:-$MYSQL_USERNAME}"
ADMIN_PASS="${MYSQL_ADMIN_PASSWORD:-$MYSQL_PASSWORD}"
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

SQL=$(cat <<SQL
DROP DATABASE IF EXISTS \`$DB_AUTH_NAME\`;
DROP DATABASE IF EXISTS \`$DB_REALM_NAME\`;
DROP DATABASE IF EXISTS \`$DB_WORLD_NAME\`;
DROP DATABASE IF EXISTS \`$DB_DBC_NAME\`;
SQL
)

if [ "$MYSQL_USERNAME" != "root" ]; then
    SQL="REVOKE ALL PRIVILEGES, GRANT OPTION FROM '$MYSQL_USERNAME'@'%';
DROP USER IF EXISTS '$MYSQL_USERNAME'@'%';
$SQL"
fi

echo "Dropping databases with prefix '${DB_PREFIX}'..."
echo "$SQL" | mariadb -h "$DB_HOST" -P "$DB_PORT" -u "$ADMIN_USER" -p"$ADMIN_PASS" $SSL_ARGS
echo "Databases dropped."
