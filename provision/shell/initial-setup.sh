#!/bin/bash

VAGRANT_CORE_FOLDER=$(echo "$1")
TMP_PWD_DIR=$(pwd)


# OS=$(/bin/bash "${VAGRANT_CORE_FOLDER}/shell/os-detect.sh" ID)
# CODENAME=$(/bin/bash "${VAGRANT_CORE_FOLDER}/shell/os-detect.sh" CODENAME)


if [[ ! -d /.puphpet-stuff ]]; then
    mkdir /.puphpet-stuff

    echo;
    echo "${VAGRANT_CORE_FOLDER}" > "/.puphpet-stuff/vagrant-core-folder.txt"

    cat "${VAGRANT_CORE_FOLDER}/shell/self-promotion.txt"
    echo "Created directory /.puphpet-stuff"
    echo "=================================="
fi


echo "# Running initial-setup apt-get update and upgrade"
echo "# =========================================="
apt-get update 
apt-get upgrade -y --no-install-recommends
touch /.puphpet-stuff/initial-setup-repo-update
echo "# Finished running initial-setup apt-get update"






echo; 
echo "# System install..."
echo "# =========================================="
echo "[0/6] Install dnsmasq exim4"
apt-get install -y dnsmasq exim4 
echo "[1/6] Install git vim curl mc man make zip"
apt-get install -y git vim curl mc man make zip
echo "[2/6] Install apache2 libapache2-mod-macro "
apt-get install -y apache2 libapache2-mod-macro 
echo "[3/6] Install PHP"
apt-get install -y php5 php-pear php5-dev php5-mysql \
               php5-pgsql php5-sqlite php5-memcache \
               php5-gd php5-xdebug php5-curl \
               php5-mcrypt php5-cli php5-xsl 
echo "[4/6] Install python"
apt-get install -y python-mysqldb python-pygresql python-psycopg2 \
               python-sqlite python-redis python-memcache \
               python-pip python-imaging 
echo "[5/6] MySQL "
apt-get install -y mysql-server mysql-client memcached \
               sqlite sqlite3 postgresql sphinxsearch redis-server 
echo "[6/6] Running apt-get -y autoremove..."
# apt-get install -y ant
apt-get -y autoremove
echo "# Finished system install"




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
    cd "$TMP_PWD_DIR"
fi 

pip install sphinxsearch

if [[ `pecl list 2>/dev/null | grep redis` == "" ]]; then
    pecl install redis
    cp /vagrant/provision/data/php/redis.ini /etc/php5/conf.d/20-redis.ini
fi





#     
#     
# if [[ ! -f /.puphpet-stuff/initial-setup-repo-update ]]; then
#     if [ "${OS}" == 'debian' ] || [ "${OS}" == 'ubuntu' ]; then
#         echo "Running initial-setup apt-get update"
#         apt-get update >/dev/null
#         touch /.puphpet-stuff/initial-setup-repo-update
#         echo "Finished running initial-setup apt-get update"
#     elif [[ "${OS}" == 'centos' ]]; then
#         echo "Running initial-setup yum update"
#         yum install yum-plugin-fastestmirror -y >/dev/null
#         yum check-update -y >/dev/null
#         echo "Finished running initial-setup yum update"

#         echo "Updating to Ruby 1.9.3"
#         yum install centos-release-SCL >/dev/null
#         yum remove ruby >/dev/null
#         yum install ruby193 facter hiera ruby193-ruby-irb ruby193-ruby-doc ruby193-rubygem-json ruby193-libyaml >/dev/null
#         gem update --system >/dev/null
#         gem install haml >/dev/null
#         echo "Finished updating to Ruby 1.9.3"

#         echo "Installing basic development tools (CentOS)"
#         yum -y groupinstall "Development Tools" >/dev/null
#         echo "Finished installing basic development tools (CentOS)"
#         touch /.puphpet-stuff/initial-setup-repo-update
#     fi
# fi

# if [[ "${OS}" == 'ubuntu' && ("${CODENAME}" == 'lucid' || "${CODENAME}" == 'precise') && ! -f /.puphpet-stuff/ubuntu-required-libraries ]]; then
#     echo 'Installing basic curl packages (Ubuntu only)'
#     apt-get install -y libcurl3 libcurl4-gnutls-dev curl >/dev/null
#     echo 'Finished installing basic curl packages (Ubuntu only)'

#     touch /.puphpet-stuff/ubuntu-required-libraries
# fi
