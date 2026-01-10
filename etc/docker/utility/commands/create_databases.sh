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

SKIP_CREATE=0
case "${DB_SKIP_CREATE:-false}" in
    1|true|TRUE|yes|YES) SKIP_CREATE=1 ;;
esac

if [ "$SKIP_CREATE" -eq 1 ] && [ -n "${EXTERNAL_DB_HOST:-}" ] && [ "$MYSQL_HOST" = "$EXTERNAL_DB_HOST" ]; then
    echo "Skipping database creation (external DB + DB_SKIP_CREATE)."
    exit 0
fi

SQL=$(cat <<SQL
CREATE DATABASE IF NOT EXISTS \`$DB_AUTH_NAME\` DEFAULT CHARACTER SET UTF8MB4 COLLATE utf8mb4_unicode_ci;
CREATE DATABASE IF NOT EXISTS \`$DB_REALM_NAME\` DEFAULT CHARACTER SET UTF8MB4 COLLATE utf8mb4_unicode_ci;
CREATE DATABASE IF NOT EXISTS \`$DB_WORLD_NAME\` DEFAULT CHARACTER SET UTF8MB4 COLLATE utf8mb4_unicode_ci;
CREATE DATABASE IF NOT EXISTS \`$DB_DBC_NAME\` DEFAULT CHARACTER SET UTF8MB4 COLLATE utf8mb4_unicode_ci;
SQL
)

if [ "$MYSQL_USERNAME" != "root" ]; then
    SQL="$SQL
GRANT ALL PRIVILEGES ON \`$DB_AUTH_NAME\`.* TO '$MYSQL_USERNAME'@'%';
GRANT ALL PRIVILEGES ON \`$DB_REALM_NAME\`.* TO '$MYSQL_USERNAME'@'%';
GRANT ALL PRIVILEGES ON \`$DB_WORLD_NAME\`.* TO '$MYSQL_USERNAME'@'%';
GRANT ALL PRIVILEGES ON \`$DB_DBC_NAME\`.* TO '$MYSQL_USERNAME'@'%';
"
fi

echo "Creating databases with prefix '${DB_PREFIX}'..."
echo "$SQL" | mariadb -h "$DB_HOST" -P "$DB_PORT" -u "$ADMIN_USER" -p"$ADMIN_PASS" $SSL_ARGS
echo "Databases created."
