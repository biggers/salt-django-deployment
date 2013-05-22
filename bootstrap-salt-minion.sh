#!/bin/bash
args=("$@")

if [ "${args[0]}" == "true" ]; then
    /vagrant/bootstrap-salt.sh daily
fi

sudo cp /vagrant/minion.conf /etc/salt/minion.conf
sudo sed -i -e "s/minionid/${args[1]}/" /etc/salt/minion.conf
sudo sed -i -e "s/master_ip/${args[2]}/" /etc/salt/minion.conf

if [ "${args[0]}" == "true" ]; then
    sudo tee -a /etc/hosts <<EOF

${args[2]}      salt salt-master
EOF
fi

sudo restart salt-minion


