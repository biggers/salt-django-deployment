#!/bin/bash

args=("$@")

if [ "${args[0]}" == "true" ]; then
    /vagrant/bootstrap-salt.sh daily
    ssh-keygen -t rsa -N "" -f /vagrant/key/pgstandby.key
    sudo apt-get install salt-master
fi

sudo cp /vagrant/master.conf /etc/salt/master
sudo restart salt-master