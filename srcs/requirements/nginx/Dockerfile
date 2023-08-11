#NGINX with TLSv1.2 or TLSv1.3 only

FROM	debian:bullseye

EXPOSE	443

RUN		apt update && apt install nginx openssl -y
RUN		mkdir /etc/nginx/ssl
RUN		openssl req -new -newkey rsa:2048 -x509 -sha256 -days 365 -nodes \
		-keyout /etc/nginx/ssl/shaas.key \
		-out /etc/nginx/ssl/shaas.crt \
		-subj "/C=DE/ST=Baden-Wuerttemberg/L=Heilbronn/O=42 Heilbronn/OU=shaas/CN=shaas/"

# remove this one, just for testing -> plus remove the actual files
COPY	*light* /var/www/html/ #change later
COPY	./conf/nginx.conf /etc/nginx/conf.d

CMD ["nginx", "-g", "daemon off;"]
