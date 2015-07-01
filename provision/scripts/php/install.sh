#!/bin/bash
set -e

DIR=$( cd $( dirname "${BASH_SOURCE[0]}" ) && pwd )
TMP_PWD_DIR=$(pwd)

# apt-cache showpkg php5

cd $DIR

# Установка версии PHP
# version 5.3
./php53.sh
# version 5.4
#VERSION=$(apt-cache showpkg php5 | grep -m 1 -o -P '5.4[^ )]+ ')


echo ">>> Installing PHP"

apt-get install \
    libapache2-mod-php5=$VERSION \
                                 \
    php5=$VERSION \
    php5-xdebug=$VERSION \
    php5-cli=$VERSION \
    php5-common=$VERSION \
    php5-curl=$VERSION \
    php5-dev=$VERSION \
    php5-gd=$VERSION \
    php5-imagick=$VERSION \
    php5-imap=$VERSION \
    php5-mcrypt=$VERSION \
    php5-mysql=$VERSION \
    php5-xdebug=$VERSION \
    php5-xsl=$VERSION \
    php5-sqlite=$VERSION \
    php5-memcached=$VERSION \

aptitude hold php5 php5-cli php5-common

./config.sh
# ./phar.sh

