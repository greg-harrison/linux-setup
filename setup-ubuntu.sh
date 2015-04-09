#!/bin/sh

_user="$(id -u -n)"
echo "Installing System, $_user"
sudo apt-get install ruby-2.0 zsh git vim 
curl -sL https://deb.nodesource.com/setup | sudo bash -
sudo apt-get install nodejs build-essential
sudo chsh -s /usr/bin/zsh $_user
./install.rb
