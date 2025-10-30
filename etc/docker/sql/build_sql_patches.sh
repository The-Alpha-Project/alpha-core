#!/bin/bash

function init_database() {
    SQL_DUMP='CREATE DATABASE `alpha_'${1}'` /*!40100 COLLATE utf8mb4_general_ci */;'$'\n'
    SQL_DUMP=${SQL_DUMP}'USE `alpha_'${1}'`;'$'\n'
    SQL_DUMP=${SQL_DUMP}$(cat /etc/databases/${1}/${1}.sql)$'\n'
    SQL_DUMP=${SQL_DUMP}$(cat /etc/databases/${1}/updates/*.sql)

    echo "${SQL_DUMP}" | docker_process_sql
}

init_database 'auth'
init_database 'dbc'
init_database 'realm'
init_database 'world'
