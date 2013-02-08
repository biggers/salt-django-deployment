============================================
What does salt-django-deployment give you?
============================================

- Nginx - loadbalancing
- Gunicorn
- Supervisord
- Postgresql - pgpool2 failover
- Rabbitmq
- Elasticsearch
- Celery
- Memcached
- Haystack - pyelasticsearch - haystack-celery
- Django CMS - with search
- Django-shop - with django-mptt categories and searchable products - rudimentary shop so far but all parts present

How to deploy salt-django-deployment.
---------------------------------------

1. Install VirtualBox.
2. Install Ruby.
5. Clone this repository to a directory or download zipfile and extract to a directory.
6. Open the directory in explorer, hold shift and right click, choose "Open command window here".
3. Install Vagrant. In the command window issue this command: "gem install vagrant"
   If on windows 7 wait for https://github.com/mitchellh/vagrant/pull/1040, or edit ssh.rb ;)
4. Install vagrant-hostmaster
   In the command window issue this command:"vagrant gem install vagrant-hostmaster"
7. Add a box.
   In the command window issue this command: "vagrant box add precise64 http://files.vagrantup.com/precise64.box"
8. Start the servers.
   In the command window issue this command: "vagrant up"
9. Login to 127.0.0.1:2222 using putty (username: vagrant / password: vagrant).

   List keys that needs to be accepted by running "sudo salt-key -L".
   
   Accept all keys "sudo salt-key -A" or individual keys.
   
   Test salt "sudo salt '*' test.ping".
   
   Provision salt minions by running "sudo salt '*' state.highstate".


