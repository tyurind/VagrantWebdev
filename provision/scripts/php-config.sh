#!/bin/bash
set -e



echo ">>> Configuring PHP"

# PHP
if [ ! -d /vagrant/runtime/xdebug ]; then
    mkdir -p /vagrant/runtime/xdebug
    chmod 777 /vagrant/runtime/xdebug
fi


cat > /etc/php5/conf.d/99-xdebug.ini <<EOF
xdebug.cli_color=1
xdebug.collect_assignments=1
xdebug.collect_params=1
xdebug.collect_return=1
xdebug.scream=0

xdebug.remote_enable=1
xdebug.remote_connect_back=1

xdebug.profiler_enable=0
xdebug.profiler_enable_trigger=1
xdebug.profiler_output_dir="/vagrant/runtime/xdebug"
xdebug.profiler_output_name="cachegrind.out.%s"

xdebug.trace_enable_trigger=1
xdebug.trace_output_dir="/vagrant/runtime/xdebug"
xdebug.trace_output_name="trace.%R"
EOF



sed -i "s/display_errors = Off/display_errors = On/g"                                       /etc/php5/apache2/php.ini
sed -i "s/display_startup_errors = Off/display_startup_errors = On/g"                       /etc/php5/apache2/php.ini
sed -i "s/error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT/error_reporting = E_ALL/g"    /etc/php5/apache2/php.ini
sed -i 's/;include_path = ".:\/usr\/share\/php"/include_path = ".:\/usr\/share\/php"/g'     /etc/php5/apache2/php.ini
sed -i 's/;date.timezone = /date.timezone = UTC/g'                                          /etc/php5/apache2/php.ini

