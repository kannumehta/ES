#! /bin/bash

# 1. Update system.
sudo apt-get update -y && sudo apt dist-upgrade -y
sudo apt-get autoremove
sudo apt-get autoclean

# 1.1 Enabled automatic updates
# sudo apt-get install unattended-upgrades
# sudo dpkg-reconfigure -plow unattended-upgrades

# 2. Add a new user name and add it to the docker group.
USERNAME=krisheth
sudo useradd -m -s /bin/bash $USERNAME
sudo passwd $USERNAME
sudo usermod -aG sudo $USERNAME
sudo usermod -aG docker $USERNAME

# 3. Install SSH on port 9898
SSH_PORT=9898
sudo ufw allow $SSH_PORT
sudo ufw show added
sudo ufw enable
sudo ufw status numbered
sudo apt-get install --assume-yes openssh-server
sudo systemctl enable ssh
sudo systemctl start ssh

# 4. Install chrony for time synchronization
sudo apt update && sudo apt -y install chrony
chronyc tracking

# 5. Disable root account
sudo passwd -l root