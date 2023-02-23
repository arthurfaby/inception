#!/bin/bash

echo "LAUNCHING SECURE"

service mysql start
mysql_secure_installation << EOF

y
y
$DATABASE_ROOT_PASSWORD
$DATABASE_ROOT_PASSWORD
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
if [ -z $(cat /tmp/.mytmpfiledontworryitdoesntexists | grep $DATABASE_NAME) ]
then
	mysql  << EOF
CREATE DATABASE $DATABASE_NAME;
CREATE USER "$DATABASE_USER"@"localhost" IDENTIFIED BY "$DATABASE_PASSWORD";
GRANT ALL PRIVILEGES ON * . * TO "$DATABASE_USER"@"localhost";
FLUSH PRIVILEGES;
EOF
	echo "DATABASE CREATED !!!!!!!!!"
else
	echo "DATABASE EXIST !!!!!!!!!"
fi

mysql > /tmp/tmpfile << EOF
SHOW DATABASES;
EOF
mysqld
