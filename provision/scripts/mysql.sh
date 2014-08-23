#!/bin/bash
set -e

echo;
echo ">>> Installing MySQL Server"
echo "--- -----------------------"

apt-get install -y mysql-server mysql-client
# ===============================================

echo;
echo ">>> Configuring MySQL"
echo "--- -----------------"

MYSQL_PASSWORD=
SQLTMP="/tmp/mysql-init.sql"

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
# ===============================================
#
echo;
echo ">>> Restart MySQL"
echo "--- -------------"
#service mysql restart

PID=`cat /var/run/mysqld/mysqld.pid`
kill ${PID}

service mysql start
# ===============================================

echo;
echo ">>> Configuring MySQL user 'admin'"
echo "--- ------------------------------"
MYSQL_ADMIN_PASSWORD="admin"

echo "
CREATE USER 'admin'@'%' IDENTIFIED BY  '${MYSQL_ADMIN_PASSWORD}';
GRANT ALL PRIVILEGES ON * . * TO  'admin'@'%' IDENTIFIED BY  '${MYSQL_ADMIN_PASSWORD}' WITH GRANT OPTION MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0 ;
FLUSH PRIVILEGES;
" > "$SQLTMP"

mysql -u root "-p${MYSQL_PASSWORD}" < "$SQLTMP"
rm "$SQLTMP"
# ===============================================

