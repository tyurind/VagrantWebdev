#!/bin/bash
set -e

#
# Configure
#
echo "# " 
echo "# Configure START services "
echo "# =========================================="
service dnsmasq start      2>/dev/null
service apache2 start      2>/dev/null
service mysql start        2>/dev/null
service postgresql start   2>/dev/null
service redis-server start 2>/dev/null
service memcached start    2>/dev/null
service sphinxsearch start 2>/dev/null
service exim4 start        2>/dev/null

#
# After configuring
#
/usr/bin/indexer --rotate --all --config /etc/sphinxsearch/sphinx.conf


echo ">>>> END"
echo "================================"