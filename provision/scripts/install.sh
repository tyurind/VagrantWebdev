#!/bin/bash
set -e

TMP_PWD_DIR=$(pwd)

echo ">>>> $0 "
echo ">>>>"


#
# Install goods
#
echo; echo; 
echo "# System update..."
echo "# =========================================="
echo;


export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get upgrade -y --no-install-recommends

apt-get install -y python-software-properties
apt-get -y autoremove
# deb http://http.debian.net/debian stable main


echo; echo;
echo  "# System install..."
echo  "# ==========================================" 
echo;

# apt-get install -y man
apt-get install -y bash-completion whois

apt-get install -y git vim curl mc make zip

apt-get install -y dnsmasq 

apt-get install -y apache2 libapache2-mod-macro 


apt-get install -y php5  php5-mysql php5-cli php5-mcrypt \
                   php5-gd php5-xdebug php5-curl php5-dev  php5-xsl 

apt-get install -y python-mysqldb python-imaging

apt-get install -y mysql-server mysql-client 

# apt-get install -y memcached sphinxsearch redis-server 
# apt-get install -y postgresql   
# apt-get install -y sqlite sqlite3
# apt-get install -y php5-pgsql php5-sqlite php5-memcache
# apt-get install -y exim4 
# apt-get install -y python-pygresql python-psycopg2 python-sqlite python-redis python-memcache


apt-get -y autoremove
apt-get -y autoclean
apt-get -y clean
