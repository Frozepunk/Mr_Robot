#!/bin/bash
# Install DNSRecon using pip

echo "Installing DNSRecon..."
pip install dnsrecon

# Verify installation
if command -v dnsrecon &> /dev/null; then
    echo "DNSRecon installed successfully."
else
    echo "DNSRecon installation failed."
fi
