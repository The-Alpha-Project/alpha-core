# ![logo](.github/logo-small.png) Alpha Core


# Enjoy or want to support the project?

[![ko-fi](https://www.ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/R6R21LO82)


## The Alpha Project - Alpha-core

Based on `0.5.3` Alpha version of World of Warcraft, `alpha-core` is an experimental emulator written in Python.

- [Database Tool](https://db.thealphaproject.eu/)

- [Discord](https://discord.gg/RzBMAKU)


## Configuration

In `etc\config` you will need to make a copy of `config.yml.dist` and rename the copy into `config.yml`, be free to edit the file as you see fit.

To generate `.map` and `.nav` files, look for the `Extractor` settings inside `config.yml`, set `wow_root_path` and then run `main.py -e`, extract both `.map` and `.nav`, after that, enable `use_map_tiles` and `use_nav_tiles` settings, for linux users you will need have access to the windows client folder.

> [!NOTE]  
> If you're not using docker, make sure the information under Database => Connection, match your MariaDB's information, by default is `alphapython` username and password for localhost (127.0.0.1).

In `etc\databases` you will see `create_databases.sql`, run this query with your root or equivalent super-user to create the relative user: `alphapython` and following databases: `alpha_realm`, `alpha_world` and `alpha_dbc`.

> [!NOTE]  
> Keep in mind if you're using docker and you wish to use `alphapython` user you may need to change the `create_databases.sql` file from 'alphapython'@'localhost' to 'alphapython'@'IPv4OfYourDockerContainer', in the case it gves you an error.

You need [Python](https://www.python.org/downloads/) 3.9 or higher, no matter the installation you choose.

## Installation (Traditional)
[MariaDB](https://mariadb.org/download/) server. For project requirements, install them with `pip3 install -r requirements.txt`.

> [!NOTE]  
> Make sure you're in your downloaded repository folder, example:
> "C:\Users\YourUsername\Documents\Github\alpha-core"


## Installtion (Docker)

Minimum requirements are [docker](https://www.docker.com/products/docker-desktop/) 19.03 or higher, and docker-compose 1.28 or higher. 
You can install `docker` through your OS package manager or [via download through the docker.com site](https://docs.docker.com/engine/install/) and `docker-compose` using `pip3 install docker-compose`.

Run: `docker-compose up -d`.


### Development in Docker

The docker-compose configuration will mount the entire project folder on `/var/wow` in the main container. To access the container run `docker-compose exec main bash` as usual, to inspect the logs `docker-compose logs -f main`.

To enable extra development features please run `docker-compose --profile dev up` to run the project with the developer profile on.

If run with the development profile the codebase will be under a continuous watch process and server will reboot everytime the code has changed. To manually restart the server run `docker-compose restart main`.

In addition, a phpmyadmin image is provided in the docker-compose for ease of browsing the database, this is accessible through compose profiles. 
You can access phpmyadmin by visiting `http://localhost:8080`.


### Rebuilding the database

To rebuild the database from scratch and apply again all the updates run  `docker-compose up --renew-anon-volumes sql`. Note: this will WIPE any custom handmade changes, including accounts.


## Servers

Currently `Alpha Project` has two servers, one focus on the development of `0.5.3` and another based on `1.12` ([Vanilla MaNGOS](https://github.com/vmangos)) for bug finding.

- `0.5.3` (2 Realms)
  - [ **GM/Dev** ] - `Tel'Abim`
  - [ **Normal** ] - `Brill`

- `1.12` (1 Realm)
  - `Kalidar`

More information in [Discord](https://discord.gg/RzBMAKU)


## Disclaimer

The `Alpha Project` does not distribute a client. You will need to find your own clean `0.5.3` client on the internet.

The `Alpha Project` Team and Owners DO NOT in any case sponsor nor support illegal public servers. If you use these projects to run an illegal public server and not for testing and learning it is your personal choice.

## License

The `Alpha Project` - Alpha-core source components are released under the [GPL-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) license.

The `Alpha Project` - Alpha-core is not an official Blizzard Entertainment product, and it is not affiliated with or endorsed by World of Warcraft or Blizzard Entertainment.