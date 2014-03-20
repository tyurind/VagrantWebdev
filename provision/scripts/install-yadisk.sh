#!/bin/bash
set -e

URL_86="http://repo.yandex.ru/yandex-disk/yandex-disk_latest_i386.deb"
URL_64="http://repo.yandex.ru/yandex-disk/yandex-disk_latest_amd64.deb"

echo; echo;
echo "# Running initial-setup JANDEX DISK"
echo "# =========================================="
echo;

    if [ "$(uname -m 2>/dev/null | grep 64)" != "" ]; then
        URL="$URL_64"
        echo ">>> URL x64"
    else
        URL="$URL_86"
        echo ">>> URL x86"
    fi



# Яндек диск
wget --no-check-certificate -O yd.deb "$URL" && \
    dpkg --install yd.deb && \
    rm yd.deb
