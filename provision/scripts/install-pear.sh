#!/bin/bash
set -e

# Installations from the PEAR, PECL and PyPI; if some of this brings errors, just remove it
echo; echo;
echo "# Installations from the PEAR, PECL and PyPI"
echo "# =========================================="
echo;


apt-get install -y php-pear 

pear config-set auto_discover 1
pear install pear.phpunit.de/phpunit phpunit/dbunit phpunit/phpunit_skeletongenerator
pear install components.ez.no/base ezc/database ezc/consoletools
pear install pear/console_commandline pear/php_codesniffer
pear install  --ignore-errors pear.twig-project.org/twig 2>/dev/null
pear install --alldeps pear.netpirates.net/autoload

## apt-get install -y python-pip
## pip install sphinxsearch

## if [[ `pecl list 2>/dev/null | grep redis` == "" ]]; then
##     pecl install redis
##     cp /vagrant/provision/data/php/redis.ini /etc/php5/conf.d/20-redis.ini
## fi


pear cc 2>/dev/null
pear update-channels
pear upgrade-all
pear cc 2>/dev/null

