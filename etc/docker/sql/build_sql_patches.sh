#!/bin/bash

function init_database() {
    DB_PREFIX="${DB_PREFIX:-alpha_}"
    DB_NAME="${DB_PREFIX}${1}"
    SQL_DUMP='CREATE DATABASE `'${DB_NAME}'` /*!40100 COLLATE utf8mb4_general_ci */;'$'\n'
    SQL_DUMP=${SQL_DUMP}'USE `'${DB_NAME}'`;'$'\n'
    SQL_DUMP=${SQL_DUMP}$(cat /etc/databases/${1}/${1}.sql)$'\n'
    SQL_DUMP=${SQL_DUMP}$(cat /etc/databases/${1}/updates/*.sql)

    echo "${SQL_DUMP}" | docker_process_sql
}

init_database 'auth'
init_database 'dbc'
init_database 'realm'
init_database 'world'
