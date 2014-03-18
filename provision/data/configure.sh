#!/bin/bash
set -e

#
# Configure
#
echo "# " 
echo "# Configure STOP services "
echo "# =========================================="
service dnsmasq stop       2>/dev/null   
service apache2 stop       2>/dev/null   
service mysql stop         2>/dev/null 
service postgresql stop    2>/dev/null      
service redis-server stop  2>/dev/null        
service memcached stop     2>/dev/null     
service sphinxsearch stop  2>/dev/null        
service exim4 stop         2>/dev/null          






#
# Start services
#
service dnsmasq start
service apache2 start
service mysql start
service postgresql start
service redis-server start
service memcached start
service sphinxsearch start
service exim4 start

#
# After configuring
#
/usr/bin/indexer --rotate --all --config /etc/sphinxsearch/sphinx.conf


echo ">>>> END"
echo "================================"
echo $TMP_PWD_DIR