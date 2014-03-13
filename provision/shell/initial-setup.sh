#!/bin/bash

VAGRANT_CORE_FOLDER=$(echo "$1")
TMP_PWD_DIR=$(pwd)


JAVA_INSTALL=
YANDEX_INDTALL=


JAVA_URL="https://googledrive.com/host/0B-rZL_vXzmg8SHY4Yno2VEhQamc/jdk-7u51-linux-i586.gz"
ANT_URL="http://apache-mirror.rbc.ru/pub/apache//ant/binaries/apache-ant-1.9.3-bin.tar.gz"


# OS=$(/bin/bash "${VAGRANT_CORE_FOLDER}/shell/os-detect.sh" ID)
# CODENAME=$(/bin/bash "${VAGRANT_CORE_FOLDER}/shell/os-detect.sh" CODENAME)

_cdhome()
{
  cd "$TMP_PWD_DIR" 
}
_cdruntime()
{
  cd "/vagrant/runtime"
}

apt-install()
{
  for i in $@ do
    echo "Running initial-setup apt-get: $i"
    apt-get install -y "$1" >/dev/null
  done
}



if [[ ! -d "/vagrant/runtime/tmp" ]]; then
  mkdir -p "/vagrant/runtime/tmp"
fi


if [[ ! -d /.vagrant-stuff ]]; then
    mkdir /.vagrant-stuff

    echo;
    echo "${VAGRANT_CORE_FOLDER}" &> "/.vagrant-stuff/vagrant-core-folder.txt"

    cat "${VAGRANT_CORE_FOLDER}/shell/self-promotion.txt"
    echo "Created directory /.vagrant-stuff"
    echo "=================================="
fi


echo "# Running initial-setup apt-get update and upgrade"
echo "# =========================================="
apt-get update 
apt-get upgrade -y --no-install-recommends

echo "# Finished running initial-setup apt-get update"
touch /.vagrant-stuff/ initial-setup-repo-update




################################################################
# System
################################################################

echo;  
echo "# System install..."
echo "# =========================================="

LN="
"
echo "$LN [0/6] Install dnsmasq exim4 ..."
apt-get install -y dnsmasq exim4 

echo "$LN [1.0/6] Install git ..."
apt-get install -y man 

echo "$LN [1.3/6] Install git ..."
apt-get install -y git 

echo "$LN [1.6/6] Install vim ..."
apt-get install -y vim 

echo "$LN [1.9/6] Install curl mc man make zip ..."
apt-get install -y curl mc make zip

echo "$LN [2/6] Install apache2 libapache2-mod-macro ..."
apt-get install -y apache2 libapache2-mod-macro 

echo "$LN [3/6] Install PHP ..."
apt-get install -y php5 php5-cli \
               php5-mysql php5-sqlite php5-memcache \
               php5-gd php5-xdebug php5-curl \
               php5-mcrypt php5-xsl php-pear

echo "$LN [4/6] Install python ..."
apt-get install -y python-mysqldb python-pygresql python-psycopg2 \
               python-sqlite python-redis python-memcache \
               python-pip python-imaging 

echo "$LN [5/6] MySQL ..."
apt-get install -y mysql-server mysql-client memcached \
               sqlite sqlite3 postgresql sphinxsearch redis-server 

echo "$LN [6/6] Running apt-get -y autoremove..."
apt-get -y autoremove

echo "# Finished system install"
touch /.vagrant-stuff/  initial-setup-repo-install


################################################################
# PHP
################################################################

echo; 
echo "# Installations from the PEAR, PECL and PyPI"
echo "# =========================================="

pear config-set auto_discover 1
pear install pear.phpunit.de/PHPUnit phpunit/DbUnit phpunit/PHPUnit_SkeletonGenerator
pear install components.ez.no/base ezc/database ezc/consoletools

pear cc 2>/dev/null 
pear update-channels
pear upgrade-all


if [ ! -f /usr/local/bin/composer ]; then
    cd /usr/local/bin && curl -sS https://getcomposer.org/installer | php \
        && chmod +x composer.phar \
        && mv composer.phar /usr/local/bin/composer
    _cdhome
fi 

pip install sphinxsearch

if [[ `pecl list 2>/dev/null | grep redis` == "" ]]; then
    pecl install redis
    cp /vagrant/provision/data/php/redis.ini /etc/php5/conf.d/20-redis.ini
fi

echo "# Finished PHP install"
touch /.vagrant-stuff/ php-required-libraries




################################################################
# JAVA
################################################################



if [[ "$JAVA_INSTALL" != "" ]]; then
  if [[ `java -version 2>/dev/null | grep Java` != "" ]]; then
    JAVA_INSTALL=
  fi
fi

if [[ "$JAVA_INSTALL" != "" ]]; then
  mkdir -p /usr/lib/java 
  cd /usr/lib/java

  wget -O - "$JAVA_URL" | tar -xzf -
  update-alternatives --install /usr/bin/java java /usr/lib/java/jdk1.7.0_51/bin/java 1000
  java -version

  wget -O - "$ANT_URL" | tar -xzf -
  update-alternatives --install /usr/bin/ant ant /usr/lib/java/apache-ant-1.9.3/bin/ant 1000
  ant -version

  _cdhome
  touch /.vagrant-stuff/java-required-libraries
fi

unset JAVA_URL ANT_URL


################################################################
# YANDEX_INSTALL
################################################################

if [[ "$YANDEX_INSTALL" != "" ]]; then
  if [[ ! -f /.vagrant-stuff/yandex-required-libraries ]]; then
    cd /vagrant/runtime/tmp
    wget -O yd.deb http://repo.yandex.ru/yandex-disk/yandex-disk_latest_i386.deb && \
        dpkg --install yd.deb && \
        rm yd.deb
    
    _cdhome
    touch /.vagrant-stuff/yandex-required-libraries
  fi
fi



################################################################
# DROPBOX_INSTALL
################################################################

# Установка программы Dropbox из командной строки
# cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86" | tar xzf -
# ~/.dropbox-dist/dropboxd
if [[ "$DROPBOX_INSTALL" != "" ]]; then
  if  [ -f /usr/local/bin/dropbox ]; then
      cd /usr/local/bin
      wget -O dropbox.py https://www.dropbox.com/download?dl=packages/dropbox.py
      chmod +x dropbox.py
      mv dropbox.py /usr/local/bin/dropbox

      _cdhome
  fi
fi