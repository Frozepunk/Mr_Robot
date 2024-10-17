#!/bin/bash

# Download the latest version of Nessus for Linux
echo "Downloading Nessus..."
curl -o Nessus.rpm https://www.tenable.com/downloads/api/v1/public/pages/nessus/downloads/15532/download?i_agree_to_tenable_license_agreement=true

# Convert the RPM package to a format Arch Linux can use (requires rpmextract or debtap)
echo "Converting Nessus RPM package..."
sudo pacman -S --noconfirm rpmextract
rpmextract.sh Nessus.rpm

# Install Nessus
echo "Installing Nessus..."
cd opt/nessus/
./install.sh

# Start the Nessus service
echo "Starting Nessus service..."
/bin/systemctl start nessusd.service
systemctl enable nessusd.service

# Print instructions to access Nessus Web UI
echo "Nessus installation complete. Access the web interface at https://localhost:8834"
