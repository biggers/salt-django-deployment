/vagrant/bootstrap-salt.sh
sudo apt-get install salt-master
salt-key --gen-keys=minion
sudo cp minion.pub /etc/salt/pki/master/minions/minion.pub
cp minion.pub /vagrant/salt/key/minion.pub
cp minion.pem /vagrant/salt/key/minion.pem
sudo cp /vagrant/salt/master.conf /etc/salt/master
sudo /etc/init.d/salt-master restart