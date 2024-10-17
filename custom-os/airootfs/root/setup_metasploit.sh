#!/bin/bash
# Install and configure Metasploit

echo "Starting PostgreSQL for Metasploit database setup..."
sudo systemctl start postgresql
sudo systemctl enable postgresql

# Initialize the Metasploit database
echo "Initializing Metasploit database..."
msfdb init

# Verify installation
if command -v msfconsole &> /dev/null; then
    echo "Metasploit installed successfully."
else
    echo "Metasploit installation failed."
fi

echo "Metasploit setup complete. Run 'msfconsole' to start the console."
