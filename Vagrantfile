# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"

  config.vm.define "master" do |master|
    config.vm.host_name = "master"
    config.vm.network :private_network, ip: "10.0.0.10"
  end

  config.vm.define "slave" do |slave|
    config.vm.host_name = "slave"
    config.vm.network :private_network, ip: "10.0.0.11"
  end

  config.vm.cloud_init content_type: "text/x-shellscript", path: "src/cloud-init.sh"
end
