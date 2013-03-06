#!/bin/bash
args=("$@")

if [ "${args[1]}" == "true" ]; then
    /vagrant/bootstrap-salt.sh daily
fi

sudo cp /vagrant/minion.conf /etc/salt/minion
sudo sed -i -e "s/minionid/${args[0]}/" /etc/salt/minion

sudo restart salt-minion 
