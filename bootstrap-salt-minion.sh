#!/bin/bash
args=("$@")
/vagrant/bootstrap-salt.sh
sudo cp /vagrant/minion.conf /etc/salt/minion
sudo sed -i -e "s/minionid/${args[0]}/" /etc/salt/minion
sudo cp /vagrant/key/minion.pub /etc/salt/pki/minion/minion.pub
sudo cp /vagrant/key/minion.pub /etc/salt/pki/minion/minion.pub
sudo /etc/init.d/salt-minion restart
