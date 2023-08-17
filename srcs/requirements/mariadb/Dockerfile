FROM	debian:bullseye

EXPOSE	3306

# install mariadb
RUN		apt update && apt install -y --no-install-recommends --no-install-suggests mariadb-server

#get mariadb config file
COPY	50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# get startup / setup file
COPY	setup.sh /bin/
RUN		chmod +x /bin/setup.sh

# setup mariadb & start the server
CMD		["setup.sh", "mysqld_safe"]
