#!/bin/bash

function init_database() {
    SQL_DUMP=${SQL_DUMP}$(cat etc/databases/${1}/updates/*.sql)
    echo $SQL_DUMP

}

type="default"
databases=()

while getopts ":u" opt; do
  case $opt in
    u)
      echo "Added to databases"
      echo $opt;
      databases+=("$OPTARG")
      ;;
  esac
done

echo $databases

if [ -z "$databases" ]; then
    echo "databases is emtpy"
    echo $databases
    databases=('dbc' 'realm' 'world')
fi

for database in "${databases[@]}"; do
  echo "init_database" "$database" "$type"
done
