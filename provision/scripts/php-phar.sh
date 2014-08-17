#!/bin/bash
set -e


echo ">>> Installations PHP Dev Tools"

cd /usr/local/bin

echo ">>> >>> conposer"
curl -sS https://getcomposer.org/installer | php && chmod +x composer.phar && mv composer.phar /usr/local/bin/composer


echo ">>> >>> PHPUnit"
wget --no-check-certificate https://phar.phpunit.de/phpunit.phar && chmod +x phpunit.phar && mv phpunit.phar /usr/local/bin/phpunit

echo ">>> >>> PHPUnit-Skelgen"
wget --no-check-certificate https://phar.phpunit.de/phpunit-skelgen.phar && chmod +x phpunit-skelgen.phar && mv phpunit-skelgen.phar /usr/local/bin/phpunit-skelgen

echo ">>> >>> PHP Autoload Builder"
wget --no-check-certificate http://phpab.net/phpab-1.14.2.phar && chmod +x phpab-1.14.2.phar && mv phpab-1.14.2.phar /usr/local/bin/phpab

# echo "# PHPLoc"
# wget --no-check-certificate https://phar.phpunit.de/phploc.phar && chmod +x phploc.phar && mv phploc.phar /usr/local/bin/phploc

# echo "# PDepend"
# wget --no-check-certificate http://static.pdepend.org/php/1.1.0/pdepend.phar && chmod +x pdepend.phar && mv pdepend.phar /usr/local/bin/pdepend

# echo "# PHpcpd"
# wget --no-check-certificate https://phar.phpunit.de/phpcpd.phar && chmod +x phpcpd.phar  && mv phpcpd.phar /usr/local/bin/phpcpd

# echo "# PHPDox"
# wget --no-check-certificate http://phpdox.de/releases/phpdox.phar && chmod +x phpdox.phar && mv phpdox.phar /usr/local/bin/phpdox
