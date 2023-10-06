FROM mariadb:11.1.2
COPY build_sql_patches.sh /docker-entrypoint-initdb.d/
RUN chmod -x /docker-entrypoint-initdb.d/build_sql_patches.sh
