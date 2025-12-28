"""Switch .env + config.yml to use local database settings."""

import os
from pathlib import Path


def main() -> int:
    env_path = Path(".env")
    cfg_path = Path("etc/config/config.yml")

    host = os.environ.get("LOCAL_DB_HOST") or "127.0.0.1"
    port = os.environ.get("LOCAL_DB_PORT") or "3306"
    user = os.environ.get("LOCAL_DB_USERNAME") or "alphapython"
    password = os.environ.get("LOCAL_DB_PASSWORD") or "alphapython"

    updates = {
        "MYSQL_HOST": host,
        "MYSQL_PORT": port,
        "MYSQL_USERNAME": user,
        "MYSQL_PASSWORD": password,
        "COMPOSE_PROFILES": "localdb",
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

    print("Local DB applied to .env and etc/config/config.yml")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
