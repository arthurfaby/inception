#!/bin/bash

function	log {
	echo -e "\e[92m[LOG] $1\e[0m"
}

function	info {
	echo -e "\e[93m[INFO] $1\e[0m"
}

if [ -d "/var/www/html/wordpress" ]
then
	info	"Wordpress is already installed."
else

	log	"Sleep during 40 secs."
	sleep 40
	log	"Going inside '/var/www/html' folder."
	cd /var/www/html
	log	"Beggining of 'wget http://wordpress.org/latest.tar.gz'."
	wget http://wordpress.org/latest.tar.gz
	log	"End of 'wget http://wordpress.org/latest.tar.gz'."
	log	"Beggining of 'tar xzf latest.tar.gz'."
	tar xzf latest.tar.gz
	log	"End of 'tar xzf latest.tar.gz'."
	log	"Removing 'latest.tar.gz' file."
	rm -f latest.tar.gz
	log	"Copy of wordpress config file."
	cp wordpress/wp-config-sample.php wordpress/wp-config.php
	log	"Change rights on wordpress folder."
	chown -R www-data:www-data /var/www/html/wordpress
	chmod -R 755 /var/www/html/wordpress

	log	"Beggining of 'wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar'."
	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	log	"End of 'wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar'."
	log	"Change rights on 'wp-cli.phar' file."
	chmod +x wp-cli.phar
	log	"Moving 'wp-cli.phar' to '/usr/local/bin/wp'."
	mv wp-cli.phar /usr/local/bin/wp

	log	"Changing wordpress config file with env variables."
	sed -i "s/database_name_here/${WORDPRESS_DB_NAME}/g" wordpress/wp-config.php
	sed -i "s/username_here/${WORDPRESS_DB_USER}/g" wordpress/wp-config.php
	sed -i "s/password_here/${WORDPRESS_DB_PASSWORD}/g" wordpress/wp-config.php
	sed -i "s/localhost/${WORDPRESS_DB_HOST}/g" wordpress/wp-config.php
	sed -i "s/false/true/g" wordpress/wp-config.php
	log	"Installing wp core."
	wp core install --path=/var/www/html/wordpress --allow-root --url=afaby.42.fr --title="My title" --admin_user=$WORDPRESS_USER_ADMIN_NAME --admin_password=$WORDPRESS_USER_ADMIN_PASSWORD --admin_email=$WORDPRESS_USER_ADMIN_EMAIL
	log "Create a wordpress user."
	wp user create $WORDPRESS_USER_NAME $WORDPRESS_USER_EMAIL --path=/var/www/html/wordpress --role=subscriber --user_pass=$WORDPRESS_USER_PASSWORD --allow-root
fi
log	"Launching '/usr/sbin/php-fpm7.3 -F -R' command."
/usr/sbin/php-fpm7.3 -F -R
