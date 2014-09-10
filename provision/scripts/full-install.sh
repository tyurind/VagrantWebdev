#!/bin/bash
set -e

TMP_PWD_DIR=$(pwd)

cd /vagrant/provision/scripts

./install.sh
./apache/install.sh
./dnsmasq.sh
# ./java.sh
# ./nodejs.sh
./mysql/install.sh
./php/install.sh
./phpmyadmin.sh
./vim/install.sh
# ./ruby.sh

cp -r /vagrant/provision/files/* /home/vagrant/
chown -R vagrant:vagrant /home/vagrant

echo ">>> System clean cache"
apt-get -y autoremove
apt-get -y autoclean
apt-get -y clean
