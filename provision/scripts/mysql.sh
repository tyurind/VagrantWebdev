#!/bin/bash
set -e

echo ">>> Installing Mysql Server"

apt-get install -y mysql-server mysql-client 


echo ">>> Configuring Apache"


SQLTMP=/tmp/mysql-init.sql
echo "
UPDATE mysql.user SET Password=PASSWORD('password') WHERE User='root';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'password';
FLUSH PRIVILEGES; 
" > "$SQLTMP"

# MySQL
sed -i "s/bind-address/#bind-address/g" /etc/mysql/my.cnf

mysqld_safe --init-file="$SQLTMP" &> /dev/null &
rm "$SQLTMP"

PID=`cat /var/run/mysqld/mysqld.pid`
kill ${PID}

service mysql start
