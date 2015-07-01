#!/usr/bin/env bash

echo ">>> Installing phpMyAdmin"

mkdir -p /usr/share/htdocs
apt-get install -y zip unzip

cd /usr/share/htdocs
if [ -d /usr/share/htdocs/phpmyadmin  ]; then
    echo ">>> ==> phpmyadmin is installed"
    exit
fi

echo ">>> ==> download (... phpmyadmin)"
wget --no-check-certificate https://github.com/phpmyadmin/phpmyadmin/archive/STABLE.zip
unzip STABLE.zip

mv phpmyadmin-STABLE phpmyadmin
rm STABLE.zip

CONF_FILE="/etc/apache2/conf.d/20-phpmyadmin.conf"
CONF_PMA_FILE="/usr/share/htdocs/phpmyadmin/config.inc.php"

cat > "$CONF_FILE" <<EOF
Alias /phpmyadmin/ /usr/share/htdocs/phpmyadmin/
<Location /usr/share/htdocs/phpmyadmin/>
    # AllowOverride All
    Order allow,deny
    Allow from all
</Location>
EOF

service apache2 restart




cat > "$CONF_PMA_FILE" < <<EOF
<?php
/* Servers configuration */
$i = 0;

/* Server: root [1] */
$i++;
$cfg['Servers'][$i]['verbose'] = 'root';
$cfg['Servers'][$i]['host'] = 'localhost';
$cfg['Servers'][$i]['port'] = '';
$cfg['Servers'][$i]['socket'] = '';
$cfg['Servers'][$i]['connect_type'] = 'tcp';
$cfg['Servers'][$i]['extension'] = 'mysqli';
$cfg['Servers'][$i]['nopassword'] = true;
$cfg['Servers'][$i]['auth_type'] = 'config';
$cfg['Servers'][$i]['user'] = 'root';
$cfg['Servers'][$i]['password'] = '';
$cfg['Servers'][$i]['AllowNoPassword'] = true;
$cfg['Servers'][$i]['CountTables'] = false;
/*
$cfg['Servers'][$i]['pmadb'] = 'phpmyadmin';
$cfg['Servers'][$i]['controluser'] = 'pma';
$cfg['Servers'][$i]['controlpass'] = 'pmapass';
$cfg['Servers'][$i]['verbose_check'] = false;
$cfg['Servers'][$i]['bookmarktable'] = 'pma_bookmark';
$cfg['Servers'][$i]['relation'] = 'pma_relation';
$cfg['Servers'][$i]['userconfig'] = 'pma_userconfig';
$cfg['Servers'][$i]['table_info'] = 'pma_table_info';
$cfg['Servers'][$i]['column_info'] = 'pma_column_info';
$cfg['Servers'][$i]['history'] = 'pma_history';
$cfg['Servers'][$i]['recent'] = 'pma_recent';
$cfg['Servers'][$i]['table_uiprefs'] = 'pma_table_uiprefs';
$cfg['Servers'][$i]['tracking'] = 'pma_tracking';
$cfg['Servers'][$i]['table_coords'] = 'pma_table_coords';
$cfg['Servers'][$i]['pdf_pages'] = 'pma_pdf_pages';
$cfg['Servers'][$i]['designer_coords'] = 'pma_designer_coords';
*/

/* Server: host [3] */
$i++;
$cfg['Servers'][$i]['verbose'] = 'host';
$cfg['Servers'][$i]['host'] = 'localhost';
$cfg['Servers'][$i]['port'] = '';
$cfg['Servers'][$i]['socket'] = '';
$cfg['Servers'][$i]['connect_type'] = 'tcp';
$cfg['Servers'][$i]['extension'] = 'mysqli';
$cfg['Servers'][$i]['auth_type'] = 'cookie';
$cfg['Servers'][$i]['user'] = '';
$cfg['Servers'][$i]['password'] = '';
$cfg['Servers'][$i]['AllowRoot'] = false;
$cfg['Servers'][$i]['CountTables'] = true;

/* End of servers configuration */

$cfg['UploadDir'] = '';
$cfg['SaveDir'] = '';
$cfg['BZipDump'] = false;
$cfg['DefaultLang'] = 'ru';
$cfg['ThemeDefault'] = 'original';
$cfg['ServerDefault'] = 1;
$cfg['CompressOnFly'] = false;
$cfg['UserprefsDeveloperTab'] = true;
$cfg['HideStructureActions'] = false;
$cfg['LoginCookieDeleteAll'] = false;
$cfg['QueryHistoryDB'] = true;
$cfg['RetainQueryBox'] = true;
$cfg['blowfish_secret'] = '51a360783193d3.45092927';
$cfg['LeftDefaultTabTable'] = 'tbl_select.php';
$cfg['MaxTableList'] = 500;

EOF

