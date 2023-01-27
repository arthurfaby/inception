FROM debian:stable-slim

RUN apt update && apt upgrade -y
RUN apt install -y nginx

COPY index.html /var/www/html/.

EXPOSE 8080

RUN cat /etc/nginx/nginx.conf
 
CMD ["nginx", "-g", "daemon off;"]
