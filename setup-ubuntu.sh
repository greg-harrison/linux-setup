#!/bin/sh

_user="$(id -u -n)"
echo "Installing System, $_user"
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y
curl -sL https://deb.nodesource.com/setup_4.x | sudo bash -
sudo rm -rf /usr/bin/docker
curl -SLO https://get.docker.com/builds/Linux/x86_64/docker-1.8.3
sudo mv docker-1.8.3 /bin/docker
sudo chmod +x /bin/docker
sudo ln -s /bin/docker /usr/bin/docker
sudo curl -SLO https://raw.githubusercontent.com/docker/docker/master/contrib/init/systemd/docker.service
sudo mv docker.service /etc/systemd/system/docker.service
sudo curl -SLO https://raw.githubusercontent.com/docker/docker/master/contrib/init/systemd/docker.socket
sudo mv docker.socket /etc/systemd/system/docker.socket
sudo groupadd docker
sudo usermod -a -G docker $_user
sudo apt-get install -y ruby zsh git vim nodejs build-essential cmake python python-dev libpython-all-dev closure-linter exuberant-ctags silversearcher-ag
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y
sudo chsh -s /usr/bin/zsh $_user
sudo -H -u $_user /usr/bin/zsh -c "cd ~/.rc/; /usr/bin/ruby install.rb;"
exit
