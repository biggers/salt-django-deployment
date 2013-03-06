#!/bin/bash

args=("$@")

if [ "${args[0]}" == "true" ]; then
    /vagrant/bootstrap-salt.sh daily
    sudo apt-get install salt-master
fi

sudo cp /vagrant/master.conf /etc/salt/master
sudo /etc/init.d/salt-master restart