[![ko-fi](https://www.ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/R6R21LO82)

# alpha-core
0.5.3 experimental emulator written in Python.

## Installation
You need Python 3.6+ and a MariaDB server. For project requirements, install them with `pip3 install -r requirements.txt`.

You will need a realm, a dbc and a world database, more info can be found in the `config.yml` file you will find inside `etc/config/`. Also, you will need to rename the `.dist` config file to match the correct config name.

Once you create the three databases, populate them using the corresponding sql files located inside `etc/databases`. If there are any sql updates, apply them in order.

## Docker
Ensure you have the `config.yml` file (see **Installation**).

Run: `docker-compose up -d`

To restart: `docker-compose restart main`


(Remember that db initialization takes a bit of time).
