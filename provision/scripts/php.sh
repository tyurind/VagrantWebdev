#!/bin/bash
set -e


echo ">>> Installing PHP"

apt-get install -y php5  php5-mysql php5-cli php5-mcrypt \
                   php5-gd php5-xdebug php5-curl php5-dev  php5-xsl 



echo ">>> Configuring PHP"

# PHP
if [ ! -d /vagrant/runtime/xdebug ]; then
    mkdir /vagrant/runtime/xdebug
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



sed -i "s/display_errors = Off/display_errors = On/g"                   /etc/php5/apache2/php.ini
sed -i "s/display_startup_errors = Off/display_startup_errors = On/g"   /etc/php5/apache2/php.ini
sed -i "s/error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT/error_reporting = E_ALL/g"    /etc/php5/apache2/php.ini
sed -i 's/;include_path = ".:\/usr\/share\/php"/include_path = ".:\/usr\/share\/php"/g'     /etc/php5/apache2/php.ini
sed -i 's/;date.timezone = /date.timezone = UTC/g'                                          /etc/php5/apache2/php.ini



echo; echo;
echo ">>> Installations PHP Dev Tools"
echo;


cd /usr/local/bin

echo ">>> >>> conposer"
curl -sS https://getcomposer.org/installer | php && chmod +x composer.phar && mv composer.phar /usr/local/bin/composer


echo ">>> >>> PHPUnit"
wget --no-check-certificate https://phar.phpunit.de/phpunit.phar && chmod +x phpunit.phar && mv phpunit.phar /usr/local/bin/phpunit

echo ">>> >>> PHPUnit-Skelgen"
wget --no-check-certificate https://phar.phpunit.de/phpunit-skelgen.phar && chmod +x phpunit-skelgen.phar && mv phpunit-skelgen.phar /usr/local/bin/phpunit-skelgen

# echo "# PHPLoc"
# wget --no-check-certificate https://phar.phpunit.de/phploc.phar && chmod +x phploc.phar && mv phploc.phar /usr/local/bin/phploc

# echo "# PDepend"
# wget --no-check-certificate http://static.pdepend.org/php/1.1.0/pdepend.phar && chmod +x pdepend.phar && mv pdepend.phar /usr/local/bin/pdepend

# echo "# PHpcpd"
# wget --no-check-certificate https://phar.phpunit.de/phpcpd.phar && chmod +x phpcpd.phar  && mv phpcpd.phar /usr/local/bin/phpcpd

# echo "# PHPDox"
# wget --no-check-certificate http://phpdox.de/releases/phpdox.phar && chmod +x phpdox.phar && mv phpdox.phar /usr/local/bin/phpdox
