#!/bin/bash
set -e


# Apache
a2enmod rewrite
a2enmod macro
a2ensite default

cp /vagrant/provision/data/apache2/httpd.conf /etc/apache2/conf.d/

mkdir -p /usr/share/localhost

cp /vagrant/provision/data/apache2/default /etc/apache2/sites-available
/vagrant/bin/internal/update-apache-vhosts

