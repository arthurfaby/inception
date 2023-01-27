FROM debian:stable-slim

RUN apt upgrade
RUN apt update
RUN apt install -y mariadb-client mariadb-server
RUN usermod -d /var/lib/mysql/ mysql

EXPOSE 3306

CMD ["mysql", "-u root"]
