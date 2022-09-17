FROM mysql:8
COPY ./my.cnf /etc/mysql/my.cnf
COPY ./scripts/ /docker-entrypoint-initdb.d/
RUN chown -R mysql:mysql /docker-entrypoint-initdb.d/