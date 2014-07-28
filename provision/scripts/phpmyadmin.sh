#!/usr/bin/env bash

echo ">>> Installing phpMyAdmin"

mkdir -p /usr/share/htdocs
apt-get install -y zip

cd /usr/share/htdocs
if [ -d /usr/share/htdocs/phpmyadmin  ]; then
    echo ">>> ==> phpmyadmin is installed"
    exit
fi

echo ">>> ==> download (... phpmyadmin)"
wget --no-check-certificate http://github.com/fobia/srv-tools-phpmyadmin/archive/master.zip
unzip master.zip

mv srv-tools-phpmyadmin-master phpmyadmin
rm master.zip

CONF_FILE="/etc/apache2/conf.d/20-phpmyadmin.conf"
cat > "$CONF_FILE" <<EOF
Alias /phpmyadmin/ /usr/share/htdocs/phpmyadmin/
<Location /usr/share/htdocs/phpmyadmin/>
    # AllowOverride All
    Order allow,deny
    Allow from all
</Location>
EOF

service apache2 restart

