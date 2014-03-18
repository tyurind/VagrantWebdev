#!/bin/bash
set -e

SQLTMP=/tmp/mysql-init.sql
echo "
UPDATE mysql.user SET Password=PASSWORD('password') WHERE User='root';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'password';
FLUSH PRIVILEGES; 
" > "$SQLTMP"

# MySQL
sed -i "s/bind-address/#bind-address/g" /etc/mysql/my.cnf

mysqld_safe --init-file="$SQLTMP" &> /dev/null &

echo "Waiting for the MySQL init..."
sleep 10s
PID=`cat /var/run/mysqld/mysqld.pid`

echo "Killing the MySQL ($PID)..."
kill ${PID}
sleep 10s

rm "$SQLTMP"
echo "Go on"

