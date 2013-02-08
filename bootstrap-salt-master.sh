#!/bin/bash

args=("$@")

if [ "${args[0]}" == "true" ]; then
    /vagrant/bootstrap-salt.sh daily
    sudo apt-get install salt-master
    salt-key --gen-keys=minion
    cp minion.pub /vagrant/key/minion.pub
    cp minion.pem /vagrant/key/minion.pem
fi

sudo cp /vagrant/master.conf /etc/salt/master
sudo /etc/init.d/salt-master restart