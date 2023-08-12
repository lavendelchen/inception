#install and configure WordPress & php-fpm (only)

FROM debian:bullseye

EXPOSE 9000

ARG PHPPATH=/etc/php/7.4/fpm

RUN apt update && apt install --no-install-recommends --no-install-suggests -y \
		ca-certificates \
		php7.4-fpm \
		php7.4-mysql \
		wget \
		tar

RUN service php7.4-fpm stop

COPY www.conf ${PHPPATH}/pool.d/

# For security reasons: Limit what kind of php-cgi's can be run by the server
# Set listen to port 9000 
RUN sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' ${PHPPATH}/php.ini && \
	sed -i "s/listen = \/run\/php\/php$PHP_VERSION_ENV-fpm.sock/listen = 9000/g" ${PHPPATH}/pool.d/www.conf && \
	sed -i 's/;listen.mode = 0660/listen.mode = 0660/g' ${PHPPATH}/pool.d/www.conf && \
	sed -i 's/;daemonize = yes/daemonize = no/g' ${PHPPATH}/pool.d/www.conf

# Download Wordpress CLI (for setup.sh)
RUN wget --no-check-certificate https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp

RUN mkdir -p /run/php/ && \
	mkdir -p /var/run/php/ && \
	mkdir -p /var/www/inception/
# Chown to www-data
RUN chown -R www-data:www-data /var/www/inception/ # does it work with slash?
# Copy wordpress conf into wordpress root dir
COPY wp-config.php /var/www/inception/

COPY setup.sh /bin/
RUN chmod +x /bin/setup.sh

CMD ["setup.sh", "php-fpm7.4", "--nodaemonize"]