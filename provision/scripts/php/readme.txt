Для начала нужно подключить репозитории squeeze. Открываем файл /etc/apt/sources.list редактором nano или другим и добавляем туда вот это:


deb http://ftp.de.debian.org/debian/ squeeze main

После чего выполняем команду apt-get update.



Перед установкой необходимо удалить всё, что связано с php 5.4.

apt-get remove --purge `dpkg -l | grep php | grep -w 5.4 | awk '{print $2}' | xargs`

Далее смотрим, какая версия php 5.3.* доступна для установки:

apt-cache showpkg php5

Будет что-то вроде этого:

Provides:
5.4.4-14 —
5.3.3-7+squeeze14

Последняя — то, что нам нужно. Для удобства присвоим ей переменную:

VERSION="5.3.3-7+squeeze14"
VERSION="5.3.29-1~dotdeb.0"

Устанавливаем основные пакеты:

apt-get install php5=$VERSION php5-cli=$VERSION php5-common=$VERSION

Также и с другими пакетами. Допустим, нужен модуль mysql.

apt-get install php5-mysql=$VERSION

Если php как модуль apache:

apt-get install libapache2-mod-php5=$VERSION

После установки, все пакеты нужно будет заморозить, чтобы при установке обновлений ОС php не был обновлён до последней версии 5.4. Делается это при помощи aptitude. Напечатайте aptitude hold и названия установленных пакетов:

aptitude hold php5 php5-cli php5-common

Если вдруг понадобилось разморозить эти пакеты, то hold следует заменить на . Пример:

aptitude unhold php5 php5-cli php5-common









==================================================


В репозиториях седьмого Дебиана оказалась только php 5.4. Но для работы многих скриптов требуется откат до версии Php 5.3. В данном посте публикую решение в рамках цикла по созданию домашнего Web-сервера. От себя добавлю, что данный блог и joomla выше 1.5 нормально работает как на php 5.4 так и на 5.3. Так что понижение версии может быть излишним.
Для начала нужно подключить репозитории squeeze. Открываем файл /etc/apt/sources.list редактором vim или другим (можно воспользоваться редактором Notepad++ о котором я говорил в предыдущем посте) и добавляем:
deb http://packages.dotdeb.org squeeze all
deb-src http://packages.dotdeb.org squeeze all
deb http://ftp.ru.debian.org/debian/ squeeze main
deb-src http://ftp.ru.debian.org/debian/ squeeze main
deb http://security.debian.org/ squeeze/updates main
deb-src http://security.debian.org/ squeeze/updates main
deb http://ftp.ru.debian.org/debian/ squeeze-updates main
deb-src http://ftp.ru.debian.org/debian/ squeeze-updates main
 Для репозитория dotdeb нужно добавить GnuPG key
wget -O - http://www.dotdeb.org/dotdeb.gpg |  apt-key add -
После чего выполняем команду apt-get update.
Перед установкой необходимо удалить всё, что связано с php 5.4 если вы уже ее установили
apt-get remove --purge `dpkg -l | grep php | grep -w 5.4 | awk '{print $2}' | xargs`
Далее смотрим, какая версия php 5.3.* доступна для установки:
apt-cache showpkg php5
Provides:
5.4.4-14+deb7u7 -
5.4.4-14+deb7u5 -
5.3.28-1~dotdeb.0 -
5.3.3-7+squeeze18 -
5.3.3-7+squeeze17 -
Ну и теперь можно ставить PHP 5.3 и отдельные пакеты с помощю aptitude
aptitude install -t squeeze php5