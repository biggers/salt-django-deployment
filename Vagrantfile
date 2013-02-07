bootstrap_salt_minions = true
bootstrap_salt_master = true

salt_minions = [
    {"identificator" => :loadbalancer, "ip" => "33.33.33.3", "minionid" => "loadbalancer"},
]

Vagrant::Config.run do |config|

  config.vm.define :saltmaster do |config|
    config.vm.box = "precise64"
    config.vm.network :hostonly, '33.33.33.2'
    config.vm.customize ["modifyvm", :id, "--memory", "256"]
    if bootstrap_salt_master
        config.vm.provision :shell, :path => "bootstrap-salt-master.sh"
    end
  end

  for salt_minion in salt_minions
    config.vm.define salt_minion["identificator"] do |config|
      config.vm.box = "precise64"
      config.vm.network :hostonly, salt_minion["ip"]
      config.vm.customize ["modifyvm", :id, "--memory", "256"]
      if bootstrap_salt_minions
        config.vm.provision :shell do |shell|
          shell.inline = "/bin/bash /vagrant/bootstrap-salt-minion.sh $1"
          shell.args = salt_minion["minionid"]
        end
      end
    end
  end
end
