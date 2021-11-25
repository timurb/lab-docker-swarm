#!/bin/sh

# Use local caching docker registry
mkdir -p /etc/docker
cat > /etc/docker/daemon.json << EOF
{
        "registry-mirrors": ["http://10.0.2.2:5000"],
        "insecure-registries":  ["10.0.2.2:5000"]
}
EOF

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
apt-add-repository "deb https://download.docker.com/linux/ubuntu  $(lsb_release -cs) stable"

apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io

curl -L --fail https://github.com/docker/compose/releases/download/1.29.2/run.sh -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose



gpasswd -a vagrant docker

