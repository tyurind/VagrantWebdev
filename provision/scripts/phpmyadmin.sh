#!/usr/bin/env bash

echo ">>> Installing phpMyAdmin"

mkdir -p /usr/share/htdocs
apt-get install -y zip

cd /usr/share/htdocs
wget --no-check-certificate http://github.com/fobia/srv-tools-phpmyadmin/archive/master.zip
unzip master.zip

mv srv-tools-phpmyadmin-master phpmyadmin
rm master.zip

cat > /etc/apache2/conf.d/phpmyadmin.conf <<EOF
Alias /phpmyadmin/ /usr/share/htdocs/phpmyadmin/
<Location /usr/share/htdocs/phpmyadmin/>
    # AllowOverride All
    Order allow,deny
    Allow from all
</Location>
EOF

service apache2 restart

