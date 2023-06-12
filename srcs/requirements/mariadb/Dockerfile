from debian:bullseye

ARG MARIADB_ROOT_PASSWORD
ARG MARIADB_DATABASE
ARG MARIADB_USER
ARG MARIADB_PASSWORD

RUN apt-get update -y
RUN	apt-get install -y mariadb-server

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/

COPY /tools/init_db.sh /tmp/init_db.sh
RUN chmod +x /tmp/init_db.sh

ENTRYPOINT ["/tmp/init_db.sh"]
