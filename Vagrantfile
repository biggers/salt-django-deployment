bootstrap_salt_minions = true # set to false to just update minion config
bootstrap_salt_master = true # set to false to just update master config

salt_minions = [
    {"identificator" => :loadbalancer, "ip" => "33.33.33.3", "minionid" => "loadbalancer", "servergroup" => "balancer1"},
]

Vagrant::Config.run do |config|

  config.vm.define :saltmaster do |config|
    config.vm.box = "precise64"
    config.vm.network :hostonly, '33.33.33.2'
    config.vm.host_name = "salt"
    config.vm.customize ["modifyvm", :id, "--memory", "256"]
    config.vm.provision :shell do |shell|
      shell.inline = "/bin/bash /vagrant/bootstrap-salt-master.sh $1"
      shell.args = (bootstrap_salt_master ? "true" : "false")
    end
  end
  
  for salt_minion in salt_minions
    config.vm.define salt_minion["identificator"] do |config|
      config.vm.box = "precise64"
      config.vm.network :hostonly, salt_minion["ip"]
      config.vm.host_name = salt_minion["minionid"]
      config.vm.customize ["modifyvm", :id, "--memory", "256"]
      config.vm.provision :shell do |shell|
        shell.inline = "/bin/bash /vagrant/bootstrap-salt-minion.sh $1 $2 $3"
        shell.args = salt_minion["minionid"] << " " << salt_minion["servergroup"] << " " << (bootstrap_salt_minions ? "true" : "false")
      end
    end
  end
  
end
