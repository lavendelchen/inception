FROM debian:bullseye

EXPOSE 3306

RUN apt update && apt install -y --no-install-recommends --no-install-suggests mariadb-server
COPY 50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY setup.sh /bin/
RUN chmod +x /bin/setup.sh

CMD ["setup.sh", "mysqld_safe"]
