#!/bin/bash
set -e


# Яндек диск
wget --no-check-certificate -O yd.deb http://repo.yandex.ru/yandex-disk/yandex-disk_latest_i386.deb && \
    dpkg --install yd.deb && \
    rm yd.deb
