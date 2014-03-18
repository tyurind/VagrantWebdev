#!/bin/bash
set -e


# Memcached
sed -i "s/-l 127.0.0.1/#-l 127.0.0.1/g" /etc/memcached.conf