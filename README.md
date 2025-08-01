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

If you're trying to run python scripts without having python `PATH` set (in the case of docker or new user of python in other platforms) make sure when running the extractor command you do `py main.py -e` (to force use of python before running the script).

> [!NOTE]  
> If you're not using docker, make sure the information under Database => Connection, match your MariaDB's information, by default is `alphapython` username and password for localhost (127.0.0.1).

In `etc\databases` you will see `create_databases.sql`, run this query with your root or equivalent super-user to create the relative user: `alphapython` and following databases: `alpha_realm`, `alpha_world` and `alpha_dbc`.

> [!NOTE]  
> Keep in mind if you're using docker and you wish to use `alphapython` user you may need to change the `create_databases.sql` file from 'alphapython'@'localhost' to 'alphapython'@'IPv4OfYourDockerContainer', in the case it gves you an error.

For each folder `dbc`, `realm` and `world` in `etc\databases` you will have their respective `dbc`, `realm` and `world` SQL then their updates under `\updates` per database that matches the folder name, `dbc\updates` would be ran in your `alpha_dbc` database.

You need [Python](https://www.python.org/downloads/) 3.9 or higher, no matter the installation you choose.

## Installation (Traditional)
[MariaDB](https://mariadb.org/download/) server. For project requirements, install them with `pip3 install -r requirements.txt`.

> [!NOTE]  
> Make sure you're in your downloaded repository folder, example:
> "C:\Users\YourUsername\Documents\Github\alpha-core"


## Installation (Docker)

Minimum requirements are [docker](https://www.docker.com/products/docker-desktop/) 19.03 or higher, and docker-compose 1.28 or higher. 
You can install `docker` through your OS package manager or [via download through the docker.com site](https://docs.docker.com/engine/install/) and `docker-compose` using `pip3 install docker-compose`.

Run: `docker-compose up -d`.


### Development in Docker

The docker-compose configuration will mount the entire project folder on `/var/wow` in the main container. To access the container run `docker-compose exec main bash` as usual, to inspect the logs `docker-compose logs -f main`.

To enable extra development features please run `docker-compose --profile dev up` to run the project with the developer profile on.

If run with the development profile the codebase will be under a continuous watch process and server will reboot everytime the code has changed. To manually restart the server run `docker-compose restart main`.

In addition, a `phpmyadmin` image is provided in the docker-compose for ease of browsing the database, this is accessible through compose profiles. 
You can access `phpmyadmin` by visiting `http://localhost:8080`.


### Rebuilding the database

To rebuild the database from scratch and apply again all the updates run  `docker-compose up --renew-anon-volumes sql`. Note: this will WIPE any custom handmade changes, including accounts.

## Client Setup

You will need to download or create file `reamlist.wtf` and place it where `WoW.exe` is located, this is what's used to set the server IP to be able to connected to the realm(s).
An example how it should look: `SET realmlist "172.25.176.1"`

After that you will need to create file `wow.ses` and the first ane second line of the file will contain the `username` then `password` for your login, depening on your server settings, this information can be or not automatically created. 
An example how it should look: 
`user`
`user`

To be able to launch client (that hasn't not been modified or altered) you will need need to start `WoWClient.exe` with `-uptodate` parametre and **highly recommended** to use `-windowed"`, the easiest way it's to do this via a windows **bat**ch file, an example of how it should look:
`start WoWClient.exe -uptodate -windowed`.

Optionally you may want to create the cache folder by adding `Rmdir /S "WDB"` before `start` command.

In-game you may or need to select te `Change Realm` button to be able to login into your realm.

When you login for the first time is recommended that you run the command `pwdchange` it will tell how it's supposed to be executed after, if you run more than 1 realm, keep in mind that the `user` and `password` are per realm, there's no "shared auth server" currently.


## Commun Issues

Can't start up the docker container or database service, example of text (this case docker):
`Error response from daemon: Ports are not available: exposing port TCP 0.0.0.0:3306 -> 0.0.0.0:0: listen tcp 0.0.0.0:3306: bind: Only one usage of each socket address (protocol/network address/port) is normally permitted.`
Make sure the `port` used for `MariaDB` is not being used by another `MariaDB`, `MySQL` or similiar services.

I get `Invalid realm list` assumed you've set the correct information in `config.yml` the server has probably not fully started yet.
You will see something similiar in your `world` terminal: `2025-08-01 01:11:25 [INFO] [01/08/2025 01:11:25] Alpha Core is now running.` this means is ready to be logged into.

> [!IMPORTANT]  
> Keep in mind the client being old and being an experimental build, you will no find much stability or perfomance, this has nothing to do with the core, it's a client exclusive issue.

## Disclaimer

The `Alpha Project` does not distribute a client. You will need to find your own clean `0.5.3` client on the internet.

The `Alpha Project` Team and Owners DO NOT in any case sponsor nor support illegal public servers. If you use these projects to run an illegal public server and not for testing and learning it is your personal choice.


## License

The `Alpha Project` - Alpha-core source components are released under the [GPL-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) license.

The `Alpha Project` - Alpha-core is not an official Blizzard Entertainment product, and it is not affiliated with or endorsed by World of Warcraft or Blizzard Entertainment.