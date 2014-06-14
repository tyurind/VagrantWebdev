#!/usr/bin/env bash

echo ">>> Installing Apache Server"

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

cat > /etc/apache2/sites-available/default <<EOF
<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/
    SetEnv DEBUG_SERVER 1

    <Directory />
        Options FollowSymLinks
        AllowOverride None
    </Directory>

    <Directory /var/www>
        Options Indexes FollowSymLinks MultiViews
        AllowOverride All
        Order allow,deny
        allow from all
    </Directory>

    ScriptAlias /cgi-bin/ /usr/lib/cgi-bin/
    <Directory "/usr/lib/cgi-bin">
        AllowOverride None
        Options +ExecCGI -MultiViews +SymLinksIfOwnerMatch
        Order allow,deny
        Allow from all
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/error.log

    # Possible values include: debug, info, notice, warn, error, crit,
    # alert, emerg.
    LogLevel warn
</VirtualHost>

<Macro VHost $domain $dir>
    <VirtualHost *:80>
        ServerAdmin webmaster@localhost
        ServerName $domain
        ServerAlias www.$domain
        DocumentRoot $dir/html
        SetEnv DEBUG_SERVER 1

        <Directory />
            Options FollowSymLinks
            AllowOverride None
        </Directory>

        <Directory $dir/html>
            Options Indexes FollowSymLinks MultiViews
            AllowOverride All
            Order allow,deny
            allow from all
        </Directory>

        ScriptAlias /cgi-bin/ $dir/cgi-bin/
        <Directory "$dir/cgi-bin">
            AllowOverride None
            Options +ExecCGI +MultiViews +SymLinksIfOwnerMatch
            Order allow,deny
            Allow from all
        </Directory>

        <IfModule php5_module>
            php_value memory_limit 128M
            php_value max_execution_time 150
            php_value request_order GP
            # php_value date.timezone Europe/Moscow
            # php_value error_log /var/www/callcentre/logs/php_errors.log
        </IfModule>

        # ErrorLog ${APACHE_LOG_DIR}/error-$domain.log
        ErrorLog  $dir/logs/error.log
        CustomLog $dir/logs/access.log common

        # Possible values include: debug, info, notice, warn, error, crit,
        # alert, emerg.
        LogLevel warn

        Include $dir/*.host.conf
    </VirtualHost>
</Macro>
#
# Vhosts begin
#

#
# Vhosts end
#
EOF

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
