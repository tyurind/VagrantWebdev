#!/bin/bash
set -e

echo ">>> Installing nodejs"

NODE_URL_86="http://nodejs.org/dist/v0.10.26/node-v0.10.26-linux-x86.tar.gz"
NODE_URL_64="http://nodejs.org/dist/v0.10.26/node-v0.10.26-linux-x64.tar.gz"
NODE_LATEST="http://nodejs.org/dist/latest/"


VM="86"
if [ "$(uname -m 2>/dev/null | grep 64)" != "" ]; then VM="64"; fi

LATEST=$(curl -sS http://nodejs.org/dist/latest/SHASUMS.txt | grep -o -P 'node-.+linux-x.+\.tar\.gz' | grep "$VM")
NODE_URL="http://nodejs.org/dist/latest/${LATEST}"

mkdir -p /usr/local/lib
cd /usr/local/lib

if [ "$(node -v 2>/dev/null | grep 'v0')" = "" ]; then
    echo ">>> ==> download (... ${LATEST})"
    exit
    wget --no-check-certificate -q -O - "$NODE_URL" | tar -xzf -
    ln -s /usr/local/lib/node*/bin/node /usr/local/bin/node
    ln -s /usr/local/lib/node*/bin/npm /usr/local/bin/npm

    echo ">>> ==> npm install (less, http-console, jsmin)"
    npm install -g less http-console jsmin

    rm -rf ~/.npm
fi
