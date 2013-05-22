# -*-ruby-*-
master_ip = "10.168.253.1"

# ssh vagrant@10.168.253.8
salt_minions = [
                {"identificator" => :dalek0, "ip" => "10.168.253.8",
                 "http" => 7080,
                 "ssl" => 7443,
                 "mem" => 1024,
                 "bootstrap" => true},
                {"identificator" => :dalek1, "ip" => "10.168.253.9",
                 "http" => 8080,
                 "ssl" => 8443,
                 "mem" => 1024, 
                 "minionid" => "dalek1",
                 "bootstrap" => true},
                {"identificator" => :dalek2, "ip" => "10.168.253.10",
                 "http" => 9080,
                 "ssl" => 9443,
                 "mem" => 1024, 
                 "minionid" => "dalek2",
                 "bootstrap" => true},
]

Vagrant.configure("2") do |config|

  salt_minions.each do |salt_minion|
    hostname = salt_minion["identificator"]

    config.vm.define salt_minion["identificator"] do |config|
    config.vm.box = "precise64"
    config.vm.box_url = "http://files.vagrantup.com/precise64.box"
    config.vm.hostname = hostname.to_s

    config.vm.network :private_network, ip: salt_minion["ip"]
    config.vm.network :forwarded_port, guest: 80, host: salt_minion["http"]
    config.vm.network :forwarded_port, guest: 443, host: salt_minion["ssl"]

    config.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id,  "--memory", salt_minion["mem"]]
      vb.gui = true     # default, false  -- headless mode
    end

    config.vm.provision :shell do |shell|
      shell.inline = "/bin/bash /vagrant/bootstrap-salt-minion.sh $1 $2 $3"
      shell.args = salt_minion["bootstrap"].to_s  + " " + hostname.to_s + " " + master_ip
    end

  end

end
end
