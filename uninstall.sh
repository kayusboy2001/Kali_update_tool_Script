#!/bin/bash

# Check if script is run with sudo
if [ "$EUID" -ne 0 ]; then 
    echo "Please run as root or with sudo"
    exit 1
fi

# Uninstall the package
apt remove -y system-update-tool kali-update-tool

# Remove any residual configuration files
apt purge -y system-update-tool kali-update-tool

# Remove the custom repository files
rm -f /etc/apt/sources.list.d/kali-update-tool.list
rm -f /etc/apt/sources.list.d/system-update-tool.list

# Update package lists
apt update

# Clean up any unnecessary packages
apt autoremove -y

echo "Uninstallation complete. The update tool and its repository have been removed."
