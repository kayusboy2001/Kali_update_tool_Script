#!/bin/bash

# Check if script is run with sudo
if [ "$EUID" -ne 0 ]; then 
    echo "Please run as root or with sudo"
    exit 1
fi

# Uninstall the package and remove any residual configuration files
apt remove --purge -y system-update-tool

# Remove the custom repository file if it exists
if [ -f /etc/apt/sources.list.d/system-update-tool.list ]; then
    rm -f /etc/apt/sources.list.d/system-update-tool.list
    echo "Removed custom repository file."
else
    echo "Custom repository file not found."
fi

# Remove the script from /usr/local/bin
if [ -f /usr/local/bin/system-update.sh ]; then
    rm -f /usr/local/bin/system-update.sh
    echo "Removed system-update.sh script."
else
    echo "system-update.sh script not found."
fi

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
