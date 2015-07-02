#!/bin/bash
set -e


echo ">>> Installations PHP Dev Tools"

mkdir -p ~/.local/bin
cd ~/.local/bin

echo ">>> >>> conposer"
curl -sS https://getcomposer.org/installer | php && chmod +x composer.phar && mv composer.phar composer


echo ">>> >>> PHPUnit"
# wget --no-check-certificate https://phar.phpunit.de/phpunit.phar && chmod +x phpunit.phar && mv phpunit.phar phpunit
wget -nv --no-check-certificate -O phpunit https://phar.phpunit.de/phpunit-4.7.6.phar && chmod +x phpunit

echo ">>> >>> PHPUnit-Skelgen"
wget -nv --no-check-certificate -O phpunit-skelgen https://phar.phpunit.de/phpunit-skelgen-2.0.1.phar && chmod +x phpunit-skelgen

echo ">>> >>> PHP Autoload Builder"
wget -nv --no-check-certificate -O phpab http://phpab.net/phpab-1.14.2.phar && chmod +x phpab

# echo "# PHPLoc"
# wget --no-check-certificate https://phar.phpunit.de/phploc.phar && chmod +x phploc.phar && mv phploc.phar /usr/local/bin/phploc

# echo "# PDepend"
# wget --no-check-certificate http://static.pdepend.org/php/1.1.0/pdepend.phar && chmod +x pdepend.phar && mv pdepend.phar /usr/local/bin/pdepend

# echo "# PHpcpd"
# wget --no-check-certificate https://phar.phpunit.de/phpcpd.phar && chmod +x phpcpd.phar  && mv phpcpd.phar /usr/local/bin/phpcpd

# echo "# PHPDox"
# wget --no-check-certificate http://phpdox.de/releases/phpdox.phar && chmod +x phpdox.phar && mv phpdox.phar /usr/local/bin/phpdox
