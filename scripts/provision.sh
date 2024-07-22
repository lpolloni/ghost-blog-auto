#!/bin/bash

# Add Docker's official GPG key:
echo "[TASK $((++count))] Add Docker's official GPG key"
sudo apt install -y ca-certificates curl >/dev/null 2>&1
sudo install -m 0755 -d /etc/apt/keyrings >/dev/null 2>&1
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc >/dev/null 2>&1
sudo chmod a+r /etc/apt/keyrings/docker.asc >/dev/null 2>&1

# Add the repository to Apt sources:
echo "[TASK $((++count))] Add the repository to Apt source"
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null >/dev/null 2>&1
sudo apt update >/dev/null 2>&1

# Install Docker:
echo "[TASK $((++count))] Install Docker"
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin >/dev/null 2>&1

# Install Apache:
echo "[TASK $((++count))] Install Apache"
sudo apt install -y apache2 >/dev/null 2>&1
sudo systemctl enable apache2 >/dev/null 2>&1
sudo systemctl start apache2 >/dev/null 2>&1

# Configure files:
echo "[TASK $((++count))] Configure data"
mkdir /opt/ghost
cp /data/docker-compose.yml /opt/ghost/ 
cp /data/example.site.conf /etc/apache2/sites-available/

# Activate Apache modules:
echo "[TASK $((++count))] Activate Apache modules"
sudo a2enmod proxy >/dev/null 2>&1
sudo a2enmod proxy_http >/dev/null 2>&1
sudo a2enmod ssl >/dev/null 2>&1
sudo a2enmod rewrite >/dev/null 2>&1

#Restart Apache:
echo "[TASK $((++count))] Restart Apache"
sudo a2ensite example.site.conf >/dev/null 2>&1
sudo systemctl restart apache2 >/dev/null 2>&1

# Run Docker Compose for Ghost:
echo "[TASK $((++count))] Run Ghost Docker Compose"
cd /opt/ghost/
docker compose up -d >/dev/null 2>&1

# Check IP Address:
echo "[TASK $((++count))] Check IP Address"
ip a | grep "inet 192.168.0." | awk '{print $2}'