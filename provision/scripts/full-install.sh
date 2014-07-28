#!/bin/bash
set -e

TMP_PWD_DIR=$(pwd)

cd /vagrant/provision/scripts

./apache.sh
./dnsmasq.sh
./java.sh
./nodejs.sh
./mysql.sh
./php.sh
./php-config.sh
./phpmyadmin.sh
./vim.sh
./ruby.sh

echo ">>> System clean cache"
apt-get -y autoremove
apt-get -y autoclean
apt-get -y clean
