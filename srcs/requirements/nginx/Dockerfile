FROM debian:buster-slim

RUN	apt update

RUN	apt install -y nginx openssl

RUN	openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/afaby.42.fr.key -out /etc/ssl/certs/afaby.42.fr.crt -subj "/C=FR/ST=Charente/L=Angouleme/O=42/OU=42/CN=afaby.42.fr"

COPY	./conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

RUN ls /var/www/html

CMD ["nginx", "-g", "daemon off;"]
