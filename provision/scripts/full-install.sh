#!/bin/bash
set -e

TMP_PWD_DIR=$(pwd)

cd /vagrant/provision/scripts

./apache.sh
./dnsmasq.sh
./java.sh
./nodejs.sh
./java.sh
./mysql.sh
./php.sh
./phpmyadmin.sh
./vim.sh

echo ">>> System clean cache"
apt-get -y autoremove
apt-get -y autoclean
apt-get -y clean
