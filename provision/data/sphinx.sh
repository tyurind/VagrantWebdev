#!/bin/bash
set -e

# Sphinx
cp /vagrant/provision/data/sphinxsearch /etc -R
chmod +x /etc/sphinxsearch/sphinx.conf
sed -i "s/START=no/START=yes/g" /etc/default/sphinxsearch

