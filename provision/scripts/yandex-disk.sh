#!/bin/bash

#!/usr/bin/env bash

echo ">>> Installing Yandex-Disk cloud"

# Яндек диск
wget -O yd.deb http://repo.yandex.ru/yandex-disk/yandex-disk_latest_i386.deb && \
    dpkg --install yd.deb && \
    rm yd.deb

