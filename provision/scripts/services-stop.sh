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
