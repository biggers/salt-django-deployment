#!/bin/sh
#. (run as 'root') Install Saltstack on Ubuntu 12.04+
#. ... within a Virtual Machine !!  (/vagrant)
add-apt-repository -y ppa:saltstack/salt
apt-get -y update
apt-get -y install salt-minion
## apt-get -y install salt-master
#. apt-get -y upgrade

#. set Salt-master location, then start Salt-minion
cp /vagrant/minion.conf /etc/salt/minion.conf
sed -i -e "s/minionid/$1/" /etc/salt/minion.conf
sed -i -e "s/master_ip/$2/" /etc/salt/minion.conf
stop salt-minion
start salt-minion
