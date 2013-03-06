bootstrap_salt_minions = true # set to false to just update minion config
bootstrap_salt_master = true # set to false to just update master config

salt_minions = [
    {"identificator" => :database1, "ip" => "33.33.33.3", "minionid" => "database1"},
    {"identificator" => :web1, "ip" => "33.33.33.10", "minionid" => "web1"},
    {"identificator" => :web2, "ip" => "33.33.33.11", "minionid" => "web2"},
=begin
    {"identificator" => :search1, "ip" => "33.33.33.4", "minionid" => "search1"},
    {"identificator" => :memcached1, "ip" => "33.33.33.5", "minionid" => "memcached1"},
    {"identificator" => :rabbitmq1, "ip" => "33.33.33.6", "minionid" => "rabbitmq1"},
    {"identificator" => :failover1, "ip" => "33.33.33.7", "minionid" => "failover1"},
    {"identificator" => :pgpool1, "ip" => "33.33.33.8", "minionid" => "pgpool1"},
    {"identificator" => :celery1, "ip" => "33.33.33.9", "minionid" => "celery1"},
    {"identificator" => :loadbalancer1, "ip" => "33.33.33.12", "minionid" => "loadbalancer1"},
=end
]

Vagrant::Config.run do |config|

  config.vm.define :saltmaster do |config|
    config.vm.box = "precise64"
    config.vm.network :hostonly, '33.33.33.2'
    config.vm.customize ["modifyvm", :id, "--memory", "256"]
    config.vm.provision :shell do |shell|
      shell.inline = "/bin/bash /vagrant/bootstrap-salt-master.sh $1"
      shell.args = (bootstrap_salt_master ? "true" : "false")
    end
  end
  
  salt_minions.each do |salt_minion|
    config.vm.define salt_minion["identificator"] do |config|
      config.vm.box = "precise64"
      config.vm.network :hostonly, salt_minion["ip"]
      config.vm.customize ["modifyvm", :id, "--memory", "256"]
      config.vm.provision :shell do |shell|
        shell.inline = "/bin/bash /vagrant/bootstrap-salt-minion.sh $1 $2"
        shell.args = salt_minion["minionid"] + " " + (bootstrap_salt_minions ? "true" : "false")
      end
    end
  end
  
end
