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
echo "deb [trusted=yes] https://raw.githubusercontent.com/kayusboy2001/Kali_update_tool_Script/main/packages ./" | tee /etc/apt/sources.list.d/system-update-tool.list

# Check if the repository was added successfully
if [ $? -ne 0 ]; then
    echo "Failed to add the repository."
    exit 1
fi

# Update package lists
if ! apt update; then
    echo "Failed to update package lists."
    exit 1
fi

echo "Repository added successfully. You can now install the package with:"
echo "sudo apt install system-update-tool"
