#!/bin/bash
set -e


# Vim
sed -i "s/\"syntax on/syntax on/g" /etc/vim/vimrc
sed -i "s/\"set background=dark/set background=dark/g" /etc/vim/vimrc