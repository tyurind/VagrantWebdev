
AG=apt-get
AGINSTALL=apt-get install -y
WGET=wget --no-check-certificate

all:
	echo $(TMP_PWD_DIR)

update:
	$(AG) update -y
	$(AG) upgrade -y --no-install-recommends

install-sys:
	$(AGINSTALL) dnsmasq exim4 
	$(AGINSTALL) man 
	$(AGINSTALL) git 
	$(AGINSTALL) vim 
	$(AGINSTALL) curl mc make zip	

install-server:
	$(AGINSTALL) apache2 libapache2-mod-macro 
	$(AGINSTALL) php5 php5-dev php5-mysql php5-pgsql php5-sqlite php5-memcache php5-gd php5-xdebug php5-curl php5-mcrypt php5-cli php5-xsl 
	$(AGINSTALL) python-mysqldb python-pygresql python-psycopg2 python-sqlite python-redis python-memcache python-imaging
	$(AGINSTALL) python-pip  
	$(AGINSTALL) mysql-server mysql-client sqlite sqlite3 postgresql
	$(AGINSTALL) memcached sphinxsearch redis-server 
	pip install sphinxsearch
                    


install-pear:
	$(AGINSTALL) php-pear
	pear config-set auto_discover 1
	pear install pear/console_commandline pear/PHP_CodeSniffer
	pear install pear.phpunit.de/PHPUnit phpunit/DbUnit phpunit/PHPUnit_SkeletonGenerator
	pear install components.ez.no/base ezc/database ezc/consoletools
	pear install --alldeps pear.netpirates.net/autoload
	cd /usr/local/bin
	
	# # conposer"
	curl -sS https://getcomposer.org/installer | php && chmod +x composer.phar && mv composer.phar /usr/local/bin/composer
	
	# # PHPUnit"
	$(WGET) https://phar.phpunit.de/phpunit.phar && chmod +x phpunit.phar && mv phpunit.phar /usr/local/bin/phpunit
	
	# # PHPUnit-Skelgen"
	$(WGET) https://phar.phpunit.de/phpunit-skelgen.phar && chmod +x phpunit-skelgen.phar && mv phpunit-skelgen.phar /usr/local/bin/phpunit-skelgen
	
	# # PHPLoc"
	$(WGET) https://phar.phpunit.de/phploc.phar && chmod +x phploc.phar && mv phploc.phar /usr/local/bin/phploc
	
	# # PDepend"
	$(WGET) http://static.pdepend.org/php/1.1.0/pdepend.phar && chmod +x pdepend.phar && mv pdepend.phar /usr/local/bin/pdepend
	
	# # PHpcpd"
	$(WGET) https://phar.phpunit.de/phpcpd.phar && chmod +x phpcpd.phar  && mv phpcpd.phar /usr/local/bin/phpcpd
	
	# # PHPDox"
	$(WGET) http://phpdox.de/releases/phpdox.phar && chmod +x phpdox.phar && mv phpdox.phar /usr/local/bin/phpdox


upgrade-pear:
	pear cc
	pear update-channels
	pear upgrade-all	