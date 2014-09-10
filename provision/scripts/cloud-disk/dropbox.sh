#!/usr/bin/env bash

echo ">>> Installing Dropbox cloud"

DIR=$( cd $( dirname "${BASH_SOURCE[0]}" ) && pwd )


if [[ "$(id -u)" == "0" ]]; then
    echo "!!!  You is root"
    exit 1
fi

cd ~


# Установка программы Dropbox из командной строки
cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86" | tar xzf -
~/.dropbox-dist/dropboxd

if  [[ ! -f ~/dropbox.py ]]; then
    wget -O dropbox.py https://www.dropbox.com/download?dl=packages/dropbox.py
    chmod +x dropbox.py
fi

if [[ "$(id -u)" == "0" ]]; then
    mv dropbox.py /usr/local/bin/dropbox
fi
