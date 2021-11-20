# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"

  config.vm.define "master" do |node|
    node.vm.host_name = "master"
    node.vm.network :private_network, ip: "192.168.77.10"

    node.vm.provision :shell, inline: "docker swarm init --advertise-addr 192.168.77.10"
  end

  config.vm.define "slave" do |node|
    node.vm.host_name = "slave"
    node.vm.network :private_network, ip: "192.168.77.11"
  end

  config.vm.cloud_init content_type: "text/x-shellscript", path: "src/cloud-init.sh"
end
