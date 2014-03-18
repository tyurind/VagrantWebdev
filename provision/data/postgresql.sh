#!/bin/bash
set -e

# # localhost:5432:postgres:postgres:password

# PostgreSQL
sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /etc/postgresql/9.1/main/postgresql.conf
echo "postgres:password" | /usr/sbin/chpasswd
cp /vagrant/provision/data/postgres/pg_hba.conf /etc/postgresql/9.1/main/

echo "localhost:5432:postgres:postgres:password" > /home/vagrant
chmod 600 /home/vagrant/.pgpass

