FROM mariadb:10.5.9
COPY build_sql_patches.sh /docker-entrypoint-initdb.d/
RUN chmod -x /docker-entrypoint-initdb.d/build_sql_patches.sh