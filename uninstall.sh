#!/bin/bash

# Check if script is run with sudo
if [ "$EUID" -ne 0 ]; then 
    echo "Please run as root or with sudo"
    exit 1
fi

# Uninstall the package
apt remove -y system-update-tool

# Remove any residual configuration files
apt purge -y system-update-tool

# Remove the custom repository files

rm -f /etc/apt/sources.list.d/system-update-tool.list

# Remove the script from /usr/local/bin
rm -f /usr/local/bin/system-update.sh

# Update package lists
apt update

# Clean up any unnecessary packages
apt autoremove -y

# Remove the add-repo.sh script if it exists in the current directory
if [ -f "./add-repo.sh" ]; then
    rm -f ./add-repo.sh
    echo "Removed add-repo.sh"
fi

# Remove this uninstall script
rm -f "$0"

echo "Uninstallation complete. The system update tool and all associated files have been removed."
