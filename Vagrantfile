Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
  config.vm.provision "shell", path: "bootstrap.sh"
  config.vm.network "forwarded_port", host: 9200, guest: 9200 # Elasticsearch
  config.vm.network "forwarded_port", host: 9300, guest: 9300 # Elasticsearch
  config.vm.network "forwarded_port", host: 5000, guest: 5000 # Logtash
  config.vm.network "forwarded_port", host: 5601, guest: 5601 # Kibana
  config.vm.synced_folder "./", "/vagrant"
   config.vm.provider "virtualbox" do |vb|
     vb.cpus = 2
     vb.gui = false
     vb.memory = 4096
     vb.name = "centos-elk-stack"
   end
end
