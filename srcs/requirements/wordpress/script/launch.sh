#!/bin/bash

mkdir /var/www
mkdir /var/www/html
cd /var/www/html
wget http://wordpress.org/latest.tar.gz
tar xfz latest.tar.gz

rm -f latest.tar.gz
cd wordpress
cp wp-config-sample.php wp-config.php

sed -i "s/database_name_here/my_database/g" wp-config.php
sed -i "s/username_here/afaby/g" wp-config.php
sed -i "s/password_here/afaby/g" wp-config.php

cat wp-config.php
