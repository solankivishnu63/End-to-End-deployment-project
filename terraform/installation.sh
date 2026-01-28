#!/bin/bash
set -e

# Log everything (very useful for Terraform debugging)
exec > /var/log/bootstrap.log 2>&1

DEFAULT_USER="ubuntu"

echo "Updating system..."
apt-get update -y

echo "Installing base packages..."
apt-get install -y \
  nginx \
  docker.io \
  curl \

echo "Enabling services..."
systemctl enable --now nginx
systemctl enable --now docker

# Add user to docker group (applies on first SSH login)
if id "$DEFAULT_USER" &>/dev/null; then
  usermod -aG docker "$DEFAULT_USER"
fi

#################################
# Install kind
#################################
echo "Installing kind..."
curl -fsSL -o /usr/local/bin/kind \
  https://kind.sigs.k8s.io/dl/latest/kind-linux-amd64
chmod +x /usr/local/bin/kind

#################################
# Install Jenkins
#################################
sudo apt update
sudo apt install -y openjdk-21-jre
sudo  wget https://pkg.jenkins.io/debian-stable/binary/jenkins_2.452.4_all.deb
sudo apt install ./jenkins_2.452.4_all.deb -y
sudo systemctl enable jenkins
sudo systemctl start jenkins
#################################

# Kubectl installation
#################################
curl -LO "https://dl.k8s.io/release/$(curl -Ls https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/
#################################
