#!/bin/bash

echo "=============================="
echo "=============================="
echo "=============================="
echo "=============================="
echo "=============================="
echo "=============================="
echo "=============================="
echo "=============================="
echo "=============================="
echo "=============================="
echo "=============================="
echo "=============================="
echo "=============================="
echo "=============================="
echo "=============================="
echo "=============================="
echo "=============================="
echo "WP_DB_NAME:${WORDPRESS_DB_NAME}"
echo "WP_DB_USER:${WORDPRESS_DB_USER}"
echo "WP_DB_PASSWORD:${WORDPRESS_DB_PASSWORD}"
echo "WP_DB_HOST:${WORDPRESS_DB_HOST}"
echo "=============================="
echo "=============================="
echo "=============================="
echo "=============================="
echo "=============================="
echo "=============================="
echo "=============================="
echo "=============================="
echo "=============================="
echo "=============================="
echo "=============================="
echo "=============================="
echo "=============================="
echo "=============================="
echo "=============================="
mkdir /var/www
mkdir /var/www/html
cd /var/www/html
wget http://wordpress.org/latest.tar.gz
tar xzf latest.tar.gz

rm -f latest.tar.gz

cp wordpress/wp-config-sample.php wordpress/wp-config.php

sed -i "s/database_name_here/${WORDPRESS_DB_NAME}/g" wordpress/wp-config.php
sed -i "s/username_here/${WORDPRESS_DB_USER}/g" wordpress/wp-config.php
sed -i "s/password_here/${WORDPRESS_DB_PASSWORD}/g" wordpress/wp-config.php
sed -i "s/localhost/${WORDPRESS_DB_HOST}/g" wordpress/wp-config.php
echo "WTFFFF"
sed -i "s/false/true/g" wordpress/wp-config.php

/usr/sbin/php-fpm7.3 -F -R
