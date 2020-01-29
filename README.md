# alpha-core
0.5.3 experimental emulator written in Python.

## Installation
You need Python 3.6+ and a MariaDB server. For project requirements, install them with `pip3 install -r requirements.txt`.

You will need a realm and a world database, more info can be found in the `config.yml` file you will find inside `etc/config/`. Also, you will need to rename the `.dist` config file to match the correct config name.

Once you create both databases, populate them using the corresponding sql files located inside `etc/databases`. If there are any sql updates, apply them in order.

Note: you will need to manually create an account in the datatabase, make sure to hash the password using SHA256.
