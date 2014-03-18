#!/bin/bash
set -e

#Dnsmasq
cp /vagrant/provision/data/dnsmasq.d/vhosts.conf /etc/dnsmasq.d
