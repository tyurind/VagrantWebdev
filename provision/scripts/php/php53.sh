#!/bin/bash
set -e

echo ">>> Configuring PHP"

echo "# php 53
deb http://ftp.debian.org/debian/ squeeze main contrib non-free
deb http://security.debian.org/ squeeze/updates main contrib non-free

" >> /etc/apt/sources.list.d/php53.list



cat > /etc/apt/preferences.d/preferences <<EOF
Package: php5*
Pin: release a=oldstable
Pin-Priority: 700

Package: libapache2-mod-php5
Pin: release a=oldstable
Pin-Priority: 700

Package: php-pear
Pin: release a=oldstable
Pin-Priority: 700

Package: php-apc
Pin: release a=oldstable
Pin-Priority: 700

Package: *
Pin: release a=stable
Pin-Priority: 600
EOF


# PHP=$(dpkg -l|grep php|grep 5.4.4|awk '{print $2}')

apt-get update
# rm -r /etc/php
# apt-get install --reinstall $PHP

