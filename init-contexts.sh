#!/bin/sh

ssh-add .vagrant/machines/master/virtualbox/private_key
ssh-add .vagrant/machines/slave/virtualbox/private_key

docker context create v0 --docker "host=ssh://vagrant@192.168.77.10"
docker context create v1 --docker "host=ssh://vagrant@192.168.77.11"

ssh vagrant@192.168.77.10 hostname
ssh vagrant@192.168.77.11 hostname
