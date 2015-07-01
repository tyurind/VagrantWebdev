#!/bin/bash
set -e

DIR=$( cd $( dirname "${BASH_SOURCE[0]}" ) && pwd )
TMP_PWD_DIR=$(pwd)

cd $DIR
####################################################

./php53.sh
# VERSION=$(php -v | grep -o -P '(?>PHP )(5[^ ]+) ')
# VERSION=${VERSION:3:-1}

echo ">>> Installing PHP"

apt-get install -y php5  php5-mysql php5-cli php5-mcrypt \
                   php5-gd php5-xdebug php5-curl php5-dev  php5-xsl \
                   php5-imap


./config.sh
./phar.sh

