#!/bin/bash

set -e
# Handle dependencies
echo "Installing dependencies"
sudo apt-get update
sudo apt-get install git curl wget apt-transport-https ca-certificates gnupg-agent software-properties-common -y
# Create Devstack user with sudo permissions
echo "Creating stack user"
sudo useradd -s /bin/bash -d /opt/stack -m stack
sudo chmod +x /opt/stack
echo "stack ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/stack
cd /opt/stack
# Install docker
echo "Install docker"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io -y
sudo usermod -aG docker $USER
newgrp docker
# Install minikube, kubectl & Helm
wget https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo cp minikube-linux-amd64 /usr/local/bin/minikube
sudo chmod +x /usr/local/bin/minikube
minikube version
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x kubectl
sudo mv kubectl /usr/local/bin/
kubectl version
echo "Starting minikube in Docker driver"
minikube start --driver=docker
echo "Install Helm"
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install helm -y
# Install demo repository which contains configurations for Prometheus and Loki
echo "Install demo repository & deploy PromLoki"
sudo -u stack bash -c 'git clone https://github.com/jevjay/demo-promloki.git'
cd demo-promloki
./bootstrap.sh >> promloki-startup.log
# Install and configure devstack
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
sudo -u stack bash -c 'HOST_IP="$(curl -H "Metadata-Flavor: Google" http://metadata/computeMetadata/v1/instance/network-interfaces/0/ip)" ./stack.sh >> devstack-startup.log'
