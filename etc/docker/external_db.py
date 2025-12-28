"""Switch .env + config.yml to use external database settings."""

import os
import sys
from pathlib import Path


def main() -> int:
    env_path = Path(".env")
    cfg_path = Path("etc/config/config.yml")

    required = [
        "EXTERNAL_DB_HOST",
        "EXTERNAL_DB_PORT",
        "EXTERNAL_DB_USERNAME",
        "EXTERNAL_DB_PASSWORD",
    ]
    missing = [key for key in required if not os.environ.get(key)]
    if missing:
        print("Missing external DB values in .env: " + ", ".join(missing), file=sys.stderr)
        return 1

    updates = {
        "MYSQL_HOST": os.environ["EXTERNAL_DB_HOST"],
        "MYSQL_PORT": os.environ["EXTERNAL_DB_PORT"],
        "MYSQL_USERNAME": os.environ["EXTERNAL_DB_USERNAME"],
        "MYSQL_PASSWORD": os.environ["EXTERNAL_DB_PASSWORD"],
        "COMPOSE_PROFILES": "",
    }

    db_prefix = os.environ.get("DB_PREFIX") or "alpha_"
    db_names = {
        "Auth": f"{db_prefix}auth",
        "Realm": f"{db_prefix}realm",
        "World": f"{db_prefix}world",
        "DBC": f"{db_prefix}dbc",
    }

    lines = env_path.read_text().splitlines()
    out = []
    seen = set()
    for line in lines:
        if not line or line.lstrip().startswith("#") or "=" not in line:
            out.append(line)
            continue
        key, _ = line.split("=", 1)
        if key in updates:
            out.append(f"{key}={updates[key]}")
            seen.add(key)
        else:
            out.append(line)
    for key, value in updates.items():
        if key not in seen:
            out.append(f"{key}={value}")
    env_path.write_text("\n".join(out) + "\n")

    host = updates["MYSQL_HOST"]
    port = updates["MYSQL_PORT"]
    user = updates["MYSQL_USERNAME"]
    password = updates["MYSQL_PASSWORD"]

    lines = cfg_path.read_text().splitlines()
    out = []
    in_db = False
    current_db = None
    for line in lines:
        stripped = line.strip()
        if stripped == "Database:":
            in_db = True
            out.append(line)
            continue
        if in_db and stripped and not line.startswith(" "):
            in_db = False
            current_db = None
        if in_db:
            indent = line[: len(line) - len(line.lstrip())]
            if len(indent) == 4 and stripped.endswith(":"):
                current_db = stripped[:-1]
            if stripped.startswith("host:"):
                line = f"{indent}host: {host}"
            elif stripped.startswith("port:"):
                line = f"{indent}port: {port}"
            elif stripped.startswith("username:"):
                line = f"{indent}username: {user}"
            elif stripped.startswith("password:"):
                line = f"{indent}password: {password}"
            elif stripped.startswith("db_name:") and current_db in db_names:
                line = f"{indent}db_name: {db_names[current_db]}"
        out.append(line)
    cfg_path.write_text("\n".join(out) + "\n")

    print("External DB applied to .env and etc/config/config.yml")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
