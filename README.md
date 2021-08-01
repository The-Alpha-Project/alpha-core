[![ko-fi](https://www.ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/R6R21LO82)

# alpha-core
0.5.3 experimental emulator written in Python.

## Installation
You need Python 3.9+ and a MariaDB server. For project requirements, install them with `pip3 install -r requirements.txt`.

You will need a realm, a dbc and a world database, more info can be found in the `config.yml` file you will find inside `etc/config/`. Also, you will need to rename the `.dist` config file to match the correct config name.

Once you create the three databases, populate them using the corresponding sql files located inside `etc/databases`. If there are any sql updates, apply them in order.

## Run in Docker

Minimum requirements are docker 19.03+ and docker-compose 1.28+. 
You can install `docker` through your OS package manager or [via download through the docker.com site](https://docs.docker.com/engine/install/) and `docker-compose` using `pip3 install docker-compose`.

1. Copy `etc/config/config.yml.dist` to `etc/config/config.yml`.
2. Run: `docker-compose up -d`.

### Development in Docker

The docker-compose configuration will mount the entire project folder on `/var/wow` in the main container. To access the container run `docker-compose exec main bash` as usual, to inspect the logs `docker-compose logs -f main`.

To enable extra development features please run `docker-compose --profile dev up` to run the project with the developer profile on.

If run with the development profile the codebase will be under a continuous watch process and server will reboot everytime the code has changed. To manually restart the server run `docker-compose restart main`.

In addition a phpmyadmin image is provided in the docker-compose for ease of browsing the database, this is accessible through compose profiles. 
You can access phpmyadmin by visiting `http://localhost:8080`.

### Rebuilding the database

To rebuild the database from scratch and apply again all the updates run  `docker-compose up --renew-anon-volumes sql`. Note: this will WIPE any custom handmade changes, including accounts.
