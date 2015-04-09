#!/bin/sh

_user="$(id -u -n)"
echo "Installing System, $_user"
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y
curl -sL https://deb.nodesource.com/setup | sudo bash -
sudo apt-get install -y ruby zsh git vim nodejs npm build-essential cmake python python-dev libpython-all-dev
sudo chsh -s /usr/bin/zsh $_user
./install.rb | zsh -
