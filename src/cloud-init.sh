#!/bin/sh

# Use local caching docker registry
mkdir -p /etc/docker
cat > /etc/docker/daemon.json << EOF
{
        "registry-mirrors": ["http://10.0.2.2:5000"]
}
EOF

apt-get update
apt-get install -y docker.io docker-compose

gpasswd -a vagrant docker

