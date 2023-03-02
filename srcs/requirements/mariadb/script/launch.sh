#!/bin/bash

function	log {
	echo -e "\e[92m[LOG] $1\e[0m"
}

function	info {
	echo -e "\e[93m[INFO] $1\e[0m"
}

if [ -d "/var/run/mysqld" ]
then
	info "Mysql is already configured."
else
	log	"Starting mysql configuration."
	groupadd -r $MYSQL_USER && useradd -rg $MYSQL_USER $MYSQL_USER
	mkdir -p /var/run/mysqld
	chown -R $MYSQL_USER:$MYSQL_USER /var/run/mysqld
	chmod 777 /var/run/mysqld
fi

if [ -d "/var/lib/mysql/${MYSQL_DATABASE}" ]
then
	info "Database '${MYSQL_DATABASE} already exists.'\e[0m"
else
log	"Starting service mysql."

service mysql start

log 	"Service mysql started."
log	"Beginning of mysql_secure_installation."

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
log	"mysql_secure_installation done."

service mysql stop

log	"Beginning of mysql_install_db."
mysql_install_db
log	"mysql_install_db done."

mysqld_safe --skip-networking --socket=/var/run/mysqld/mysqld.sock &
MY_PID=$!
log	"mysqld_safe started with pid : '$MY_PID'."
log	"Beginning of the loop."
for i in {30..0}
do
	if mysql --database=mysql <<<'SELECT 1' &> /dev/null
	then
		log	"Break inside the loop."
		break
	fi
	log	"Sleep 1 second inside loop"
	sleep 1
done
log	"Outside the loop."



log	"Create database."

mysql -e "CREATE DATABASE $MYSQL_DATABASE;"
log	"Create user."
mysql -e "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
log	"Grant all privileges on user."
mysql -e "GRANT ALL ON ${MYSQL_DATABASE}.* TO '$MYSQL_USER'@'%';"
log	"Flush privileges."
mysql -e "FLUSH PRIVILEGES;"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD'"
mysql -uroot -p$MYSQL_ROOT_PASSWORD -e "FLUSH PRIVILEGES;"

log	"Killing : '$MY_PID'."
kill "$MY_PID"

fi
log	"Launching 'mysqld --bind-address=0.0.0.0' command"
mysqld --bind-address=0.0.0.0
