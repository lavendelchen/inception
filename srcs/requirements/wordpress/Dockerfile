FROM	debian:bullseye

EXPOSE	9000

# path to php-fpm version
ARG		PHPPATH=/etc/php/7.4/fpm

# install everything necessary
RUN		apt update && apt install --no-install-recommends --no-install-suggests -y \
			ca-certificates \
			php7.4-fpm \
			php7.4-mysql \
			wget \
			tar

# stop php-fpm since it runs after installation by default
RUN		service php7.4-fpm stop

# get php-fpm config
COPY	www.conf ${PHPPATH}/pool.d/

# For security reasons: Limit what kind of php-cgi's can be run by the server
# Set listen to port 9000 
RUN		sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' ${PHPPATH}/php.ini && \
		sed -i "s/listen = \/run\/php\/php$PHP_VERSION_ENV-fpm.sock/listen = 9000/g" ${PHPPATH}/pool.d/www.conf && \
		sed -i 's/;listen.mode = 0660/listen.mode = 0660/g' ${PHPPATH}/pool.d/www.conf && \
		sed -i 's/;daemonize = yes/daemonize = no/g' ${PHPPATH}/pool.d/www.conf

# Download Wordpress CLI to be used in setup.sh
RUN		wget --no-check-certificate https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
		chmod +x wp-cli.phar && \
		mv wp-cli.phar /usr/local/bin/wp

# make necessary directories
RUN		mkdir -p /run/php/ && \
		mkdir -p /var/run/php/ && \
		mkdir -p /var/www/inception/

# give www-data user ownership over the inception dir
RUN		chown -R www-data:www-data /var/www/inception/

# get wordpress conf
COPY	wp-config.php /var/www/inception/

# get startup / setup file
COPY	setup.sh /bin/
RUN		chmod +x /bin/setup.sh

# setup wordpress & start the service
CMD		["setup.sh", "php-fpm7.4", "--nodaemonize"]