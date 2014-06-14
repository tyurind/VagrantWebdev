#!/bin/bash

echo ">>> Installing dnsmasq"

apt-get install -y dnsmasq 


echo "address=/loc/127.0.0.1" > /etc/dnsmasq.d/vhosts.conf
