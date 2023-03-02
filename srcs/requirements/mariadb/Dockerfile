FROM debian:buster-slim

RUN apt update
RUN apt install -y mariadb-server

COPY ./script/launch.sh /usr/bin/launch.sh

CMD ["/bin/bash", "/usr/bin/launch.sh"]
