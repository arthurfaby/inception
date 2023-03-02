FROM debian:buster-slim

RUN apt update && apt install -y php-mysql php7.3-fpm wget
COPY 	./script/launch.sh 	/usr/bin/launch.sh
COPY 	./conf/www.conf		/etc/php/7.3/fpm/pool.d/www.conf

RUN mkdir /run/php

CMD ["/bin/bash", "/usr/bin/launch.sh"]
