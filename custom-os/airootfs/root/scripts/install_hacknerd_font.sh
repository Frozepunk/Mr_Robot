#!/bin/bash

# Script to install Hack Nerd Font on Arch Linux
FONT_DIR="$HOME/.local/share/fonts"
FONT_NAME="Hack Nerd Font"
AUR_PACKAGE="nerd-fonts-hack"
DOWNLOAD_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Hack.zip"

# Function to install via AUR
install_via_aur() {
    echo "Checking for yay (AUR helper)..."
    if ! command -v yay &> /dev/null; then
        echo "yay is not installed. Please install yay to proceed."
        exit 1
    fi
    
    echo "Installing $FONT_NAME via yay..."
    yay -S $AUR_PACKAGE --noconfirm
}

# Function to manually install the font
manual_install() {
    echo "Installing $FONT_NAME manually..."

    # Create the font directory if it doesn't exist
    mkdir -p "$FONT_DIR"

    # Download and unzip the Hack Nerd Font
    wget "$DOWNLOAD_URL" -O /tmp/Hack.zip
    unzip /tmp/Hack.zip -d "$FONT_DIR"

    # Update the font cache
    fc-cache -fv

    # Clean up
    rm /tmp/Hack.zip

    echo "$FONT_NAME has been installed manually in $FONT_DIR."
}

# Main script logic
echo "Installing $FONT_NAME on your system..."

# Check if yay is installed
if command -v yay &> /dev/null; then
    install_via_aur
else
    echo "yay (AUR helper) is not installed. Installing manually..."
    manual_install
fi

echo "$FONT_NAME installation complete!"

