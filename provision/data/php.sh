#!/bin/bash

# PHP
if [ ! -d /vagrant/runtime/xdebug ]; then
    mkdir /vagrant/runtime/xdebug
    chmod 777 /vagrant/runtime/xdebug
fi

cp /vagrant/provision/data/php/xdebug.ini /etc/php5/conf.d/99-xdebug.ini


sed -i "s/display_errors = Off/display_errors = On/g" /etc/php5/apache2/php.ini
sed -i "s/display_startup_errors = Off/display_startup_errors = On/g" /etc/php5/apache2/php.ini
sed -i "s/error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT/error_reporting = E_ALL/g" /etc/php5/apache2/php.ini
sed -i 's/;include_path = ".:\/usr\/share\/php"/include_path = ".:\/usr\/share\/php"/g' /etc/php5/apache2/php.ini
sed -i 's/;date.timezone = /date.timezone = UTC/g' /etc/php5/apache2/php.ini
