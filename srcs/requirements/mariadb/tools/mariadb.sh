#!/bin/bash

sed -i 's/bind-address            = 127.0.0.1/bind-address = 0.0.0.0/g' /etc/mysql/mariadb.conf.d/50-server.cnf

folder_name="/var/lib/mysql/$DB_NAME"

if [ -d "$folder_name" ]; then
  echo "Folder '$folder_name' exists in the current directory."
else
  {
/etc/init.d/mariadb start

mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$SQL_ROOT_PASSWORD';"

mysql -u root -p$SQL_ROOT_PASSWORD -e  "CREATE DATABASE $DB_NAME;"

mysql -u root  -p$SQL_ROOT_PASSWORD -e "CREATE USER '$USER_NAME'@'%' IDENTIFIED BY '$USER_PASSWORD';"

mysql -u root  -p$SQL_ROOT_PASSWORD -e "grant all privileges on $DB_NAME.* TO '$USER_NAME'@'%' identified by '$USER_PASSWORD';"

mysql -u root  -p$SQL_ROOT_PASSWORD -e "flush privileges;"
}
fi

mysqld_safe
