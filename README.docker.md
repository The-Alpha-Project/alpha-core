# ![logo](.github/logo-small.png) Alpha Core - Docker & Makefile Guide

---

## ✅ Requirements

- [Docker](https://www.docker.com/products/docker-desktop/) `19.03+`
- Docker Compose v2 (`docker compose`)

---

## ⚡ Quick Start (Local DB)

1. Create `.env`:
   ```bash
   cp env.dist .env
   ```
1. Create `config.yml`:
   ```bash
   make config
   ```
2. Ensure local DB is selected:
   ```bash
   make internal_db
   ```
3. Build and start everything:
   ```bash
   make setup-all
   ```

> [!NOTE]  
> If the database is still starting, `make db-setup` may fail the first time.  
> Just rerun it after a few seconds.
>
> If you run `docker compose down -v`, the local DB volume is removed and the databases are empty.
> Run `make db-setup` or `make db-restore` after that.

---

## 🗄️ Database Workflow (Makefile)

- Create databases:
  ```bash
  make db-create
  ```
- Drop databases:
  ```bash
  make db-drop
  ```
- Populate schema:
  ```bash
  make db-populate
  ```
- Apply updates:
  ```bash
  make db-update
  ```
- Full setup (create → populate → update):
  ```bash
  make db-setup
  ```
- Backup:
  ```bash
  make db-backup
  ```
- Restore (use a specific backup folder name):
  ```bash
  make db-restore BACKUP=<folder>
  ```

> [!NOTE]  
> All database names use the prefix from `.env` (`DB_PREFIX`).

---

## 🔌 External Database

1. Set these values in `.env`:
   ```
   EXTERNAL_DB_HOST=
   EXTERNAL_DB_PORT=3306
   EXTERNAL_DB_USERNAME=
   EXTERNAL_DB_PASSWORD=
   ```
2. Apply external DB config:
   ```bash
   make external_db
   ```
3. Start containers:
   ```bash
   make up
   ```

This updates `etc/config/config.yml` with concrete values and disables the local `sql`
service by clearing `COMPOSE_PROFILES`.

---

## 🔁 Switch Back to Local DB

```bash
make internal_db
make up
```

This rewrites `etc/config/config.yml` with local values and enables the `localdb` profile.

---

## ⚙️ Important `.env` Values

- `DB_PREFIX=alpha_`  
  Database names become `${DB_PREFIX}auth`, `${DB_PREFIX}realm`, `${DB_PREFIX}world`, `${DB_PREFIX}dbc`.
- `MYSQL_PORT=3306`  
  Port used *inside* the Docker network.
- `MYSQL_HOST_PORT=3300`  
  Port exposed on your host (useful when 3306 is already in use).
- `COMPOSE_PROFILES=localdb`  
  Enables the local MariaDB container.

---

## 🛠️ Permissions Tip

If `config.yml` is owned by root (often created by a container), fix it once:
```bash
sudo chown $USER:$USER etc/config/config.yml
```
