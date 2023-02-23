FROM debian:buster-slim

RUN apt upgrade
RUN apt update
RUN apt install -y mariadb-server
#RUN usermod -d /var/lib/mysql mysql
#RUN rm -r /run/mysqld/mysqld.sock 
#RUN mkdir -p /run/mysqld 
#RUN chown -R mysql:mysql /run/mysqld
EXPOSE 3306

COPY ./script/launch.sh /usr/bin/launch.sh

CMD ["/bin/bash", "/usr/bin/launch.sh"]
