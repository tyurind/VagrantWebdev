#!/bin/bash
set -e


# Vim
echo ">>> Installing vim"

apt-get install -y vim

sed -i "s/\"syntax on/syntax on/g"                      /etc/vim/vimrc
sed -i "s/\"set background=dark/set background=dark/g"  /etc/vim/vimrc