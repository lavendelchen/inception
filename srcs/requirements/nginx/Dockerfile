#NGINX with TLSv1.2 or TLSv1.3 only

FROM	debian:bullseye

EXPOSE	443

RUN		apt update && apt install -y --no-install-recommends --no-install-suggests \
			nginx \
			openssl
RUN		mkdir /etc/nginx/certs
RUN		openssl req -new -newkey rsa:2048 -x509 -sha256 -days 365 -nodes \
		-keyout /etc/nginx/certs/shaas.key \
		-out /etc/nginx/certs/shaas.crt \
		-subj "/C=DE/ST=Baden-Wuerttemberg/L=Heilbronn/O=42 Heilbronn/OU=shaas/CN=shaas/"

COPY	nginx.conf	/etc/nginx/
COPY	server.conf	/etc/nginx/conf.d/

RUN mkdir -p /var/www/
# Chown to www-data
RUN chown -R www-data:www-data /var/www/ # does it work with slash?

CMD ["nginx", "-g", "daemon off;"]
