#!/bin/bash
set -e


echo ">>> Installing PHP"

apt-get install -y php5  php5-mysql php5-cli php5-mcrypt \
                   php5-gd php5-xdebug php5-curl php5-dev  php5-xsl

