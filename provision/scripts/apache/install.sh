#!/usr/bin/env bash

echo ">>> Installing Apache Server"

DIR=$( cd $( dirname "${BASH_SOURCE[0]}" ) && pwd )

# [[ -z "$1" ]] && { echo "!!! IP address not set. Check the Vagrant file."; exit 1; }

# Add repo for latest FULL stable Apache
# (Required to remove conflicts with PHP PPA due to partial Apache upgrade within it)
# sudo add-apt-repository -y ppa:ondrej/apache2

# Update Again
# sudo apt-get update

# Install Apache
apt-get install -y apache2 libapache2-mod-macro 

echo ">>> Configuring Apache"

# cp /vagrant/provision/data/apache2/httpd.conf /etc/apache2/conf.d/
# cp /vagrant/provision/data/apache2/default /etc/apache2/sites-available
# /vagrant/bin/internal/update-apache-vhosts

cat ${DIR}/apache-config.conf > /etc/apache2/sites-available/default 

mkdir -p /usr/share/htdocs/

cat > /etc/apache2/conf.d/httpd.conf <<EOF
ServerName debian
DocumentRoot /usr/share/htdocs/

ErrorLog ${APACHE_LOG_DIR}/error.log
LogLevel warn

<Directory />
    Options Includes Indexes FollowSymLinks
    # AllowOverride All
    Order deny,allow
    Allow from all
    Satisfy all
</Directory>


Alias /Tools/ /usr/share/htdocs/Tools/
<Location /usr/share/htdocs/Tools/>
    # AllowOverride All
    Order allow,deny
    Allow from all
</Location>
<Directory /usr/share/htdocs>
    Options Indexes FollowSymLinks MultiViews
    # AllowOverride All
    Order allow,deny
    Allow from all
</Directory>
EOF


# Apache
a2enmod rewrite
a2enmod macro
a2ensite default 

sudo service apache2 restart
