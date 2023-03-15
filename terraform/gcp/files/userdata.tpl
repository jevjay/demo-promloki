#!/bin/bash

set -e
# Handle dependencies
echo "Installing dependencies"
sudo apt-get update
sudo apt-get install -y git
# Create Devstack user with sudo permissions
echo "Creating stack user"
sudo useradd -s /bin/bash -d /opt/stack -m stack
sudo chmod +x /opt/stack
echo "stack ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/stack
# Install and configure devstack
cd /opt/stack
echo "Cloning devstack"
sudo -u stack bash -c 'git clone https://opendev.org/openstack/devstack'
cd devstack
cat <<EOT >> local.conf
[[local|localrc]]
ADMIN_PASSWORD=${admin_pass}
DATABASE_PASSWORD=${admin_pass}
RABBIT_PASSWORD=${admin_pass}
SERVICE_PASSWORD=${admin_pass}
EOT
echo "Running devstack setup"
sudo -u stack bash -c 'HOST_IP="$(curl -H "Metadata-Flavor: Google" http://metadata/computeMetadata/v1/instance/network-interfaces/0/ip)" SERVICE_HOST="$(curl -H "Metadata-Flavor: Google" http://metadata/computeMetadata/v1/instance/network-interfaces/0/access-configs/0/external-ip)" ./stack.sh >> startup.log'
