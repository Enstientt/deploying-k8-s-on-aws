#!/bin/bash

# Exit on any error
set -e

# Check if the required environment variable is set
if [ -z "$HOSTNAME" ]; then
  echo "The HOSTNAME environment variable is not set. Exiting."
  exit 1
fi

# 1. Set the hostname of the machine
sudo hostnamectl set-hostname "$HOSTNAME"
echo "Hostname set to $HOSTNAME"

# 2. Add hostname to /etc/hosts for DNS resolution (localhost $name)
echo "127.0.0.1 $HOSTNAME" | sudo tee -a /etc/hosts
echo "Added $HOSTNAME to /etc/hosts"

# 3. Change the password of the user to "master01"
echo "Changing password for the current user to 'master01'"
echo "$USER:master01" | sudo chpasswd

# 4. Modify /etc/ssh/sshd_config to enable PasswordAuthentication and ChallengeResponseAuthentication
sudo sed -i '/^#PasswordAuthentication/s/^#//' /etc/ssh/sshd_config
sudo sed -i '/^PasswordAuthentication/c\PasswordAuthentication yes' /etc/ssh/sshd_config
sudo sed -i '/^#ChallengeResponseAuthentication/s/^#//' /etc/ssh/sshd_config
sudo sed -i '/^ChallengeResponseAuthentication/c\ChallengeResponseAuthentication yes' /etc/ssh/sshd_config

# 5. Restart SSH service to apply changes
sudo systemctl restart sshd
echo "SSH configuration updated and service restarted"

echo "All tasks completed successfully."
