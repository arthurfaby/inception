#!/bin/bash

echo "LAUNCHING SECURE"

#rm -rf /var/lib/mysql/*
#rm -rf /var/lib/mysqld/*
service mysql start
service mysqld start
service mariadb start
mysql_secure_installation << EOF

y
y
$MYSQL_ROOT_PASSWORD
$MYSQL_ROOT_PASSWORD
y
y
y
y
EOF

echo "SECURE DONE"
echo "LAUNCHING DATABASE"

mysql > /tmp/.mytmpfiledontworryitdoesntexists << EOF
SHOW DATABASES;
EOF
if [ -z $(cat /tmp/.mytmpfiledontworryitdoesntexists | grep $MYSQL_DATABASE) ]
then
	mysql  << EOF
CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\`;
CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
GRANT ALL ON \`${MYSQL_DATABASE}\`.* TO '$MYSQL_USER'@'%';
FLUSH PRIVILEGES;
EOF
	echo "DATABASE CREATED !!!!!!!!!"
else
	echo "DATABASE EXIST !!!!!!!!!"
fi

mysqld
