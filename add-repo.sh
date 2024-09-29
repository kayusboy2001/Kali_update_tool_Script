#!/bin/bash

# Check if script is run with sudo
if [ "$EUID" -ne 0 ]; then 
    echo "Please run as root or with sudo"
    exit 1
fi

# Check if running on Kali Linux
if ! grep -q 'Kali' /etc/os-release; then
    echo "This script is intended for Kali Linux only."
    exit 1
fi

# Add the repository
echo "deb [trusted=yes] https://raw.githubusercontent.com/kayusboy2001/Kali_update_tool_Script/main/packages ./" | tee /etc/apt/sources.list.d/kali-update-tool.list

# Update package lists
apt update

echo "Repository added successfully. You can now install the package with:"
echo "sudo apt install kali-update-tool"
