#!/bin/bash
set -e

TMP_PWD_DIR=$(pwd)

#
# Configure
#
echo "# " 
echo "# Configure "
echo "# =========================================="
service dnsmasq stop
service apache2 stop
service mysql stop
service postgresql stop
service redis-server stop
service memcached stop
service sphinxsearch stop
service exim4 stop

#Dnsmasq
# cp /vagrant/provision/data/dnsmasq.d/vhosts.conf /etc/dnsmasq.d

# Apache
a2enmod rewrite
a2enmod macro
a2ensite default
cp /vagrant/provision/data/apache2/httpd.conf /etc/apache2/conf.d/
mkdir -p /usr/share/localhost
cp /vagrant/provision/data/apache2/default /etc/apache2/sites-available
/vagrant/bin/internal/update-apache-vhosts

# PHP
if [ ! -d /vagrant/runtime/xdebug ]; then
    mkdir /vagrant/runtime/xdebug
    chmod 777 /vagrant/runtime/xdebug
fi
cp /vagrant/provision/data/php/xdebug.ini /etc/php5/conf.d/99-xdebug.ini

sed -i "s/display_errors = Off/display_errors = On/g" /etc/php5/apache2/php.ini
sed -i "s/display_startup_errors = Off/display_startup_errors = On/g" /etc/php5/apache2/php.ini
sed -i "s/error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT/error_reporting = E_ALL/g" /etc/php5/apache2/php.ini
sed -i 's/;include_path = ".:\/usr\/share\/php"/include_path = ".:\/usr\/share\/php"/g' /etc/php5/apache2/php.ini


# MySQL
sed -i "s/bind-address/#bind-address/g" /etc/mysql/my.cnf

mysqld_safe --init-file=/vagrant/provision/data/mysql-init.sql &> /dev/null &
echo "Waiting for the MySQL init..."
sleep 10s
PID=`cat /var/run/mysqld/mysqld.pid`
echo "Killing the MySQL ($PID)..."
kill ${PID}
sleep 10s
echo "Go on"

# PostgreSQL
sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /etc/postgresql/9.1/main/postgresql.conf
echo "postgres:password" | /usr/sbin/chpasswd
cp /vagrant/provision/data/postgres/pg_hba.conf /etc/postgresql/9.1/main/
cp /vagrant/provision/data/.pgpass /home/vagrant
chmod 600 /home/vagrant/.pgpass

# Redis
sed -i "s/bind 127.0.0.1/#bind 127.0.0.1/g" /etc/redis/redis.conf

# Memcached
sed -i "s/-l 127.0.0.1/#-l 127.0.0.1/g" /etc/memcached.conf

# Sphinx
cp /vagrant/provision/data/sphinxsearch /etc -R
chmod +x /etc/sphinxsearch/sphinx.conf
sed -i "s/START=no/START=yes/g" /etc/default/sphinxsearch

# Vim
sed -i "s/\"syntax on/syntax on/g" /etc/vim/vimrc
sed -i "s/\"set background=dark/set background=dark/g" /etc/vim/vimrc


#
# Start services
#
service dnsmasq start
service apache2 start
service mysql start
service postgresql start
service redis-server start
service memcached start
service sphinxsearch start
service exim4 start

#
# After configuring
#
/usr/bin/indexer --rotate --all --config /etc/sphinxsearch/sphinx.conf


echo ">>>> END"
echo "================================"
echo $TMP_PWD_DIR