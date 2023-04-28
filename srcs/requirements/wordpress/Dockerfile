#install and configure WordPress & php-fpm (only)


FROM debian:buster

EXPOSE 9000

#RUN apt update && apt install -y \
#	#php \
#	#php-cgi \
#	#php-mysql \
#	php-fpm
#	#php-pdo \
#	#php-gd php-cli \
#	#php-mbstring \
#	#redis \
#	#php-redis \

ADD https://wordpress.org/latest.tar.gz /var/www/latest.tar.gz
RUN cd /var/www/ && \
	tar -xvf latest.tar.gz && \
	rm -rf latest.tar.gz

ENTRYPOINT bash

#ENTRYPOINT musn’t be started with a command running an infinite
#loop