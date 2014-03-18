#!/bin/bash
set -e


# Redis
sed -i "s/bind 127.0.0.1/#bind 127.0.0.1/g" /etc/redis/redis.conf