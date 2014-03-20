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

# deb http://http.debian.net/debian stable main

echo; echo;
echo  "# System install..."
echo  "# ==========================================" 
echo;


apt-get install -y bash-completion whois

apt-get install -y git vim curl mc man make zip

apt-get install -y dnsmasq exim4 

apt-get install -y apache2 libapache2-mod-macro 

apt-get install -y php5 php5-dev php5-mysql php5-sqlite  \
                   php5-gd php5-xdebug php5-curl php5-mcrypt php5-cli php5-xsl 

apt-get install -y python-mysqldb python-sqlite 

apt-get install -y mysql-server mysql-client sqlite sqlite3

# apt-get install -y  memcached sphinxsearch redis-server 
# apt-get install -y  postgresql \
#                     php5-memcache php5-pgsql \
#                     python-pygresql python-psycopg2 \
#                     python-redis python-memcache python-imaging

apt-get -y autoremove
