# ![logo](.github/logo-small.png) Alpha Core

---

## ❤️ Enjoy the Project or Want to Support?

[![Ko-fi](https://www.ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/R6R21LO82)

---

## The Alpha Project - `alpha-core`

`alpha-core` is an experimental emulator written in Python for version `0.5.3` of the **Friends & Family Alpha** of *World of Warcraft*.

- [Database Tool](https://db.thealphaproject.eu/)
- [Discord Community](https://discord.gg/RzBMAKU)

---

## ⚙️ Configuration

For Docker Compose + Makefile usage, see `README.docker.md`.

1. In `etc/config`, create a copy of `config.yml.dist` and rename it to `config.yml`.  
   Edit the file as needed for your setup.

2. You need **Python 3.11 or higher**. Install it from [python.org](https://www.python.org/downloads/).

3. **Generate `.map` and `.nav` files**
   - In `config.yml`, configure the `Extractor` section by setting `wow_root_path`.
   - Run:
     ```bash
     python main.py -e
     ```
     This extracts `.map` and `.nav` files.
   - After extraction, enable `use_map_tiles` and `use_nav_tiles` in the config.

4. **If Python isn't on your PATH** (common with Docker or fresh installs), use:
   ```bash
   py main.py -e
   ```

> [!NOTE]  
> If you're not using Docker, ensure that `Database => Connection` in `config.yml` matches your MariaDB credentials.  
> By default:  
> ```
> username: alphapython
> password: alphapython
> host: 127.0.0.1
> ```

5. Create the databases using the utility scripts:
   - `make db-create`
   - Uses `.env` values (`MYSQL_USERNAME`, `MYSQL_PASSWORD`, `DB_PREFIX`)
   - Creates `${DB_PREFIX}auth`, `${DB_PREFIX}realm`, `${DB_PREFIX}world`, `${DB_PREFIX}dbc`

6. Each folder (`auth`, `dbc`, `realm`, `world`) in `etc/databases` contains:
   - Base SQL files
   - Updates in the `/updates` subfolder  
     Example: `dbc/updates` should be applied to the `${DB_PREFIX}dbc` database.

---

## 📦 Installation

### Traditional Setup
- Install [MariaDB](https://mariadb.org/download/).
- Install project requirements:
  ```bash
  pip3 install -r requirements.txt
  ```

> [!NOTE]  
> Make sure you're inside the project folder before running commands. Example:  
> `/home/user/GitHub/alpha-core`

---

### Docker Setup
- Minimum requirements:
  - [Docker](https://www.docker.com/products/docker-desktop/) `19.03+`
  - `docker-compose` `1.28+` (install with `pip3 install docker-compose` if needed)

See `README.docker.md` for Docker Compose and Makefile workflows.

- Start the containers:
  ```bash
  docker-compose up -d
  ```

#### Development in Docker
- The project is mounted at `/var/wow` inside the main container.
- Access the container:
  ```bash
  docker-compose exec main bash
  ```
- View logs:
  ```bash
  docker-compose logs -f main
  ```
- Enable developer mode (hot reload, auto-restart on changes):
  ```bash
  docker-compose --profile dev up
  ```
- Manually restart the server:
  ```bash
  docker-compose restart main
  ```
- **phpMyAdmin** is available at: `http://localhost:8080`.

#### Rebuild the Database
To wipe and rebuild from scratch (removes custom data, including accounts):
```bash
docker-compose up --renew-anon-volumes sql
```

---

## 🖥 Client Setup

1. Create `realmlist.wtf` in the same folder as `WoW.exe`:
   ```
   SET realmlist "127.0.0.1"
   ```

2. (Optional) Clear the cache by adding the following before the `start` command in your batch file:
   ```
   Rmdir /S "WDB"
   ```

3. In-game, you may need to click **Change Realm** to log into your server.

4. On your first login, it is recommended to run:
   ```
   pwdchange
   ```
   Follow the on-screen instructions. If you run more than one realm, keep in mind that the username and password are **per realm**—there is no shared auth server currently.

### Auth Options

#### Legacy
- Create `wow.ses`. The **first** and **second** lines must contain your `username` and `password`:
  ```
  username
  password
  ```
- To launch an **unmodified** client, start `WoWClient.exe` with the `-uptodate` parameter (and it's highly recommended to use `-windowed`). Example batch file:
  ```bat
  start WoWClient.exe -uptodate -windowed
  ```

#### SRP6
- **Login Server** — requires a `login.txt` file at the WoW root pointing to the login server, e.g.:
  ```
  127.0.0.1:3724
  ```
- **WoW.exe** should be executed with elevated admin rights so it can read/write `wow.ses`.
- **Update Server (Optional)** — requires an `Update.txt` file at `WoW/Data` pointing to the update server, e.g.:
  ```
  127.0.0.1:9081
  ```

---

## ⚠️ Common Issues

- **Port already in use (MariaDB / Docker):**
  ```text
  Error response from daemon: Ports are not available: exposing port TCP 0.0.0.0:3306 -> 0.0.0.0:0: listen tcp 0.0.0.0:3306: bind: Only one usage of each socket address (protocol/network address/port) is normally permitted.
  ```
  Make sure port `3306` is not being used by another `MariaDB`, `MySQL`, or similar service.

- **Invalid realm list**  
  If you've set the correct information in `config.yml` but still get this error, the server likely hasn't fully started yet.  
  Look for a message similar to:
  ```
  2025-08-01 01:11:25 [INFO] [01/08/2025 01:11:25] Alpha Core is now running.
  ```
  When you see this, it is ready to accept logins.

> [!IMPORTANT]  
> Due to the age and experimental nature of the `0.5.3` client build, you may experience stability and performance issues. These are client-related and **not** caused by the core server implementation.

---

## Disclaimer

The `Alpha Project` **does not** distribute a client. You will need to obtain a clean `0.5.3` client yourself.

The `Alpha Project` **does not** encourage unofficial public servers. If you use these projects to run an unofficial public server rather than for testing and learning, it is your personal choice.

---

## License

The `Alpha Project` – alpha-core source components are released under the [GPL-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) license.

`alpha-core` is **not** an official Blizzard Entertainment product and is **not** affiliated with or endorsed by *World of Warcraft* or Blizzard Entertainment.
