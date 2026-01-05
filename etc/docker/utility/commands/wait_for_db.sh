#!/bin/sh

wait_for_db() {
    DB_HOST="${DB_HOST:-$MYSQL_HOST}"
    DB_PORT="${DB_PORT:-$MYSQL_PORT}"
    ATTEMPTS="${DB_WAIT_ATTEMPTS:-30}"
    INTERVAL="${DB_WAIT_INTERVAL:-1}"

    echo "Waiting for DB at ${DB_HOST}:${DB_PORT}..."
    i=0
    while [ "$i" -lt "$ATTEMPTS" ]; do
        if DB_HOST="$DB_HOST" DB_PORT="$DB_PORT" python3 - <<'PY'
import os
import socket
import sys

host = os.getenv("DB_HOST") or os.getenv("MYSQL_HOST") or "localhost"
port = int(os.getenv("DB_PORT") or os.getenv("MYSQL_PORT") or "3306")
try:
    with socket.create_connection((host, port), timeout=2):
        pass
except Exception:
    sys.exit(1)
sys.exit(0)
PY
        then
            echo "DB is ready."
            return 0
        fi
        i=$((i + 1))
        sleep "$INTERVAL"
    done

    echo "Timed out waiting for DB at ${DB_HOST}:${DB_PORT}."
    return 1
}
