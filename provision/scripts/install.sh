#!/bin/bash
set -e

DIR=$( cd $( dirname "${BASH_SOURCE[0]}" ) && pwd )

TMP_PWD_DIR=$(pwd)

echo ">>>> $0 "

echo ">>> System update"
apt-get update

echo ">>> System upgrade"
apt-get upgrade -y --no-install-recommends

echo ">>> System install"
apt-get install -y python-software-properties \
                   bash-completion whois \
                   git curl mc make zip \
                   sqlite sqlite3                              \
                   python-mysqldb python-sqlite python-memcache \
                   python-pip python-imaging \

                   # python-mysqldb python-imaging python-pygresql python-psycopg2  python-redis


echo ">>> System clean cache"
apt-get -y autoremove
apt-get -y autoclean
apt-get -y clean
