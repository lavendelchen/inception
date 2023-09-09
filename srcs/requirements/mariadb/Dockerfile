FROM	debian:bullseye

EXPOSE	3306

# Install mariadb
RUN		apt update && apt install -y --no-install-recommends --no-install-suggests mariadb-server

# Get mariadb config file
COPY	50-server.cnf /etc/mysql/mariadb.conf.d/

# Get startup / setup file
COPY	setup.sh /bin/
RUN		chmod +x /bin/setup.sh

# Setup mariadb & start the server
CMD		["setup.sh", "mysqld_safe"]
