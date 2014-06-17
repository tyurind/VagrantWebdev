#!/bin/bash
set -e



echo ">>> Installing ruby"

apt-get install -y ruby1.9.3


echo ">>> >>> Installing ruby >> gem "

gem install rubygems-update 
update_rubygems  


echo ">>> >>> Installing ruby >> gem >> rake"

gem install rake
