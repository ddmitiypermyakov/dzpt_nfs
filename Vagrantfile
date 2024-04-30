# -*- mode: ruby -*-
# vim: set ft=ruby :

Vagrant.configure(2) do |config| 
 #config.vm.box = "centos/7/2004" 
  config.vm.box = "centos/8/2011" 
 #config.vm.box_version = "2004.01" 
 config.vm.synced_folder "sync/", "/vagrant", type: "rsync", create: "true"
 config.vm.provider "virtualbox" do |v| 
 v.memory = 256 
 v.cpus = 1 
 end 
 config.vm.define "nfss" do |nfss| 
 nfss.vm.network "private_network", ip: "192.168.50.10",  virtualbox__intnet: "net1" 
 nfss.vm.hostname = "nfss" 
 #box.vm.provision "shell", path: "nfs_server.sh", name: "nfss"
 end 
 config.vm.define "nfsc" do |nfsc| 
 nfsc.vm.network "private_network", ip: "192.168.50.11",  virtualbox__intnet: "net1" 
 nfsc.vm.hostname = "nfsc" 
 
 #box.vm.provision "shell", path: "nfs_client.sh", name: "nfsc"
 end 
end