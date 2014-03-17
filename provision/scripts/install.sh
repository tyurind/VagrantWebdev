#!/bin/bash
set -e

TMP_PWD_DIR=$(pwd)

echo ">>>> $0 "
echo ">>>>"


#
# Install goods
#
echo; 
echo "# System update..."
echo "# =========================================="

export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get upgrade -y --no-install-recommends
# apt-get install -y python-software-properties

# deb http://http.debian.net/debian stable main

echo; 
echo "# System install..."
echo "# =========================================="
apt-get install -y dnsmasq exim4 
apt-get install -y git vim curl mc man make zip
apt-get install -y apache2 libapache2-mod-macro 
apt-get install -y php5 php-pear php5-dev php5-mysql php5-pgsql php5-sqlite php5-memcache \
                   php5-gd php5-xdebug php5-curl php5-mcrypt php5-cli php5-xsl 
apt-get install -y python-mysqldb python-pygresql python-psycopg2 python-sqlite python-redis python-memcache \
                   python-pip python-imaging 
apt-get install -y mysql-server mysql-client memcached \
                   sqlite sqlite3 postgresql sphinxsearch redis-server 
# apt-get install -y ant
apt-get -y autoremove

# Installations from the PEAR, PECL and PyPI; if some of this brings errors, just remove it
echo; 
echo "# Installations from the PEAR, PECL and PyPI"
echo "# =========================================="

pear config-set auto_discover 1
pear install pear.phpunit.de/PHPUnit phpunit/DbUnit phpunit/PHPUnit_SkeletonGenerator
pear install components.ez.no/base ezc/database ezc/consoletools
pear install pear/console_commandline pear/PHP_CodeSniffer
pear install --alldeps pear.netpirates.net/autoload

pip install sphinxsearch

if [[ `pecl list 2>/dev/null | grep redis` == "" ]]; then
    pecl install redis
    cp /vagrant/provision/data/php/redis.ini /etc/php5/conf.d/20-redis.ini
fi

pear cc
pear update-channels
pear upgrade-all

if [ ! -f /usr/local/bin/composer ]; then
    cd /usr/local/bin

    echo "# conposer"
    curl -sS https://getcomposer.org/installer | php && chmod +x composer.phar && mv composer.phar /usr/local/bin/composer

    echo "# PHPUnit"
    wget --no-check-certificate https://phar.phpunit.de/phpunit.phar && chmod +x phpunit.phar && mv phpunit.phar /usr/local/bin/phpunit

    echo "# PHPUnit-Skelgen"
    wget --no-check-certificate https://phar.phpunit.de/phpunit-skelgen.phar && chmod +x phpunit-skelgen.phar && mv phpunit-skelgen.phar /usr/local/bin/phpunit-skelgen

    echo "# PHPLoc"
    wget --no-check-certificate https://phar.phpunit.de/phploc.phar && chmod +x phploc.phar && mv phploc.phar /usr/local/bin/phploc

    echo "# PDepend"
    wget --no-check-certificate http://static.pdepend.org/php/1.1.0/pdepend.phar && chmod +x pdepend.phar && mv pdepend.phar /usr/local/bin/pdepend

    echo "# PHpcpd"
    wget --no-check-certificate https://phar.phpunit.de/phpcpd.phar && chmod +x phpcpd.phar  && mv phpcpd.phar /usr/local/bin/phpcpd

    echo "# PHPDox"
    wget --no-check-certificate http://phpdox.de/releases/phpdox.phar && chmod +x phpdox.phar && mv phpdox.phar /usr/local/bin/phpdox

    cd "$TMP_PWD_DIR"
fi 