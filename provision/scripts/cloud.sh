#!/bin/bash

# Яндек диск
wget -O yd.deb http://repo.yandex.ru/yandex-disk/yandex-disk_latest_i386.deb && \
    dpkg --install yd.deb && \
    rm yd.deb

# Установка программы Dropbox из командной строки
# cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86" | tar xzf -
# ~/.dropbox-dist/dropboxd

if  [ -f /usr/local/bin/dropbox ]; then
    wget -O dropbox.py https://www.dropbox.com/download?dl=packages/dropbox.py
    chmod +x dropbox.py
    mv dropbox.py /usr/local/bin/dropbox
fi