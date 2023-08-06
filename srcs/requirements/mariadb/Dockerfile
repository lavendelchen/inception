FROM debian:bullseye

EXPOSE 3306

RUN apt update && apt install mariadb-server -y
COPY 50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY setup.sh /bin/
RUN chmod +x /bin/setup.sh

CMD ["setup.sh", "mysqld_safe"]
