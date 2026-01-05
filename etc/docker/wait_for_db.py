#!/usr/bin/env python3
import os
import sys
import time

import socket


def wait_for_db() -> int:
    host = os.getenv("MYSQL_HOST", "sql")
    port = int(os.getenv("MYSQL_PORT", "3306"))
    timeout = int(os.getenv("DB_WAIT_TIMEOUT", "60"))
    interval = float(os.getenv("DB_WAIT_INTERVAL", "2"))

    start = time.time()
    while True:
        try:
            with socket.create_connection((host, port), timeout=3):
                pass
            return 0
        except Exception as exc:
            if time.time() - start >= timeout:
                print(f"DB wait timeout after {timeout}s: {exc}", file=sys.stderr)
                return 1
            time.sleep(interval)


def main() -> int:
    cmd = sys.argv[1:]
    if not cmd:
        print("Usage: wait_for_db.py <command> [args...]", file=sys.stderr)
        return 2
    status = wait_for_db()
    if status != 0:
        return status
    os.execvp(cmd[0], cmd)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
