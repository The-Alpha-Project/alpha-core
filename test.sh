#!/bin/bash

function init_database() {
    local database="$1"
    docker cp "etc/databases/${database}/updates/updates.sql" alpha-core-sql:/tmp/updates.sql
    docker exec alpha-core-sql mysql -u root -ppwd "$database" < /tmp/updates.sql
    echo "Done with $database"
}

type="default"
databases=('dbc' 'realm' 'world')

for database in "${databases[@]}"; do
    echo "Initializing database $database"
    init_database "$database"
done

