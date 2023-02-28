FROM debian:buster-slim

RUN apt update && apt install -y php php-mysql php7.3-fpm wget mariadb-client

COPY 	./script/launch.sh 	/usr/bin/launch.sh
COPY 	./conf/www.conf		/etc/php/7.3/fpm/pool.d/www.conf


RUN mkdir /run/php
#RUN /bin/bash /usr/bin/launch.sh

#RUN chown -R www-data:www-data /var/www/html/wordpress

CMD ["/bin/bash", "/usr/bin/launch.sh"]
