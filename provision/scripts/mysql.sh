#!/bin/bash
set -e

echo ">>> Installing MySQL Server"

apt-get install -y mysql-server mysql-client


echo ">>> Configuring MySQL"

MYSQL_PASSWORD=

SQLTMP=/tmp/mysql-init.sql
echo "
UPDATE mysql.user SET Password=PASSWORD('${MYSQL_PASSWORD}') WHERE User='root';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
FLUSH PRIVILEGES;
" > "$SQLTMP"
echo $MYSQL_PASSWORD > /home/vagrant/mysqpass

# MySQL
sed -i "s/bind-address/#bind-address/g" /etc/mysql/my.cnf

mysqld_safe --init-file="$SQLTMP" &> /dev/null &
rm "$SQLTMP"

PID=`cat /var/run/mysqld/mysqld.pid`
kill ${PID}

service mysql start
