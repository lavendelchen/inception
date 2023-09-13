FROM	debian:bullseye

EXPOSE	443

# Install nginx & openssl (for making certificates)
RUN		apt update && apt install -y --no-install-recommends --no-install-suggests \
			nginx \
			openssl

# Make certificates
RUN		mkdir /etc/nginx/certs
RUN		openssl req -new -newkey rsa:2048 -x509 -sha256 -days 365 -nodes \
			-keyout /etc/nginx/certs/shaas.key \
			-out /etc/nginx/certs/shaas.crt \
			-subj "/C=DE/ST=Baden-Wuerttemberg/L=Heilbronn/O=42 Heilbronn/OU=shaas/CN=shaas/"

# Get nginx config
COPY	nginx.conf	/etc/nginx/
COPY	server.conf	/etc/nginx/conf.d/

# Give www-data user ownership over the inception dir
RUN		mkdir -p /var/www/
RUN		chown -R www-data:www-data /var/www/

# Run nginx
CMD		["nginx", "-g", "daemon off;"]
