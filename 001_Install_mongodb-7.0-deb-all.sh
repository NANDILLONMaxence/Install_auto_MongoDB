#!/bin/bash

# Step 1: Install gnupg and curl if not already installed
sudo apt-get update
sudo apt-get install -y gnupg curl

# Import the MongoDB public GPG key
curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | \
   sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg \
   --dearmor

# Step 2: Create MongoDB sources list file for Debian 11 "Bullseye"
echo "deb [ signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] http://repo.mongodb.org/apt/debian `lsb_release -cs`/mongodb-org/7.0 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list

# Step 3: Reload local package database
sudo apt-get update

# Step 4: Install MongoDB packages
sudo apt-get install -y mongodb-org

# Optional: Pin MongoDB package to prevent unintended upgrades
echo "mongodb-org hold" | sudo dpkg --set-selections
echo "mongodb-org-database hold" | sudo dpkg --set-selections
echo "mongodb-org-server hold" | sudo dpkg --set-selections
echo "mongodb-mongosh hold" | sudo dpkg --set-selections
echo "mongodb-org-mongos hold" | sudo dpkg --set-selections
echo "mongodb-org-tools hold" | sudo dpkg --set-selections

# Step 5: Start MongoDB
sudo systemctl start mongod

# Step 6: Verify MongoDB status
sudo systemctl status mongod

# Optional: Enable MongoDB to start on system reboot
sudo systemctl enable mongod

# Step 7: Reload local package database
sudo apt-get update

# Step 8: Stop MongoDB (if needed)
# sudo systemctl stop mongod

# Step 9: Restart MongoDB (if needed)
# sudo systemctl restart mongod

# Step 10: Remove MongoDB packages (if needed)
# sudo apt-get purge "mongodb-org*"

# Step 11: Remove MongoDB data directories (if needed)
# sudo rm -r /var/log/mongodb
# sudo rm -r /var/lib/mongodb
