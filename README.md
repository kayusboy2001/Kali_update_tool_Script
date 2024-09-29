# Kali_update_tool_Script

# System Update Tool

This tool provides a simple graphical interface for running system updates and upgrade on Kali Linux systems.

## Installation

You can install this tool using apt. Follow these steps:

1. Download and run the repository addition script:
```
wget https://raw.githubusercontent.com/kayusboy2001/Kali_update_tool_Script/main/add-repo.sh
chmod +x add-repo.sh
sudo ./add-repo.sh
```

2. Install the package:
```
sudo apt install system-update-tool
```

## Usage

After installation, you should see a "System Update" icon in your applications menu. Click it to run the update tool.
The tool will prompt for your sudo password, then show a progress bar as it updates and upgrades your system.

## Note

This tool requires sudo privileges to run system updates. Always be cautious when running scripts with sudo privileges.
