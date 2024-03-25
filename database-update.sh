#!/bin/bash

function init_database() {
    docker cp etc/databases/${1}/updates/updates.sql alpha-core-sql:/tmp/updates.sql
    docker exec -it alpha-core-sql sh -c "mariadb -u root -ppwd alpha_${1} < /tmp/updates.sql"
    docker exec -it alpha-core-sql sh -c "rm /tmp/updates.sql"
    echo "Done with ${1}"
}

type="default"
databases=('dbc' 'realm' 'world')

for database in "${databases[@]}"; do
  echo "Updated"  "$database" "$type"
  init_database $database
done 

echo "Done"
echo "Please restart server"
