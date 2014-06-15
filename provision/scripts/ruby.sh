#!/bin/bash
set -e

apt-get install -y ruby1.9.3

gem install rubygems-update 

update_rubygems  


gem install rake
