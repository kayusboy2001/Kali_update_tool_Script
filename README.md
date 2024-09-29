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





## Uninstallation Guide

If you want to uninstall the **system-update-tool** and remove the repository that was added, follow these steps:

### 1. Uninstall the `system-update-tool` Package
To remove the installed package, use the `apt` command:

```
sudo apt remove --purge system-update-tool
```
This command will uninstall the package and remove its configuration files.

### 2. Remove the Added Repository
If you want to remove the repository that was added by the add-repo.sh script, delete the corresponding file from the sources list. Typically, the script adds a .list file in the /etc/apt/sources.list.d/ directory. You can delete it as follows:

```
sudo rm /etc/apt/sources.list.d/system-update-tool.list
```

### 3. Clean Up Unnecessary Packages
After removing the repository and the package, you can clean up any unused dependencies and package information:

```
sudo apt autoremove
sudo apt update
```

### 4. Delete the Local Script Files (Optional)
If you no longer need the local script files (add-repo.sh or any other downloaded files), you can delete them:

```
rm add-repo.sh
```

This ensures no unnecessary files are left behind on your system.

### Explanation:

1. **Uninstallation Command**: Uses `sudo apt remove --purge` to ensure the package and its configuration files are removed completely.
2. **Removing the Repository**: Instructs to manually delete the repository added by the script.
3. **Cleaning Up**: Recommends running `sudo apt autoremove` to clean up any orphaned dependencies.
4. **Script Cleanup**: Optionally suggests removing the downloaded script files.

## Using the Uninstallation Script
you can uninstall the tool and clean up your system by running:

```
wget https://raw.githubusercontent.com/kayusboy2001/Kali_update_tool_Script/main/uninstall.sh
chmod +x uninstall.sh
sudo ./uninstall.sh
```

This script will:

Uninstall the package names (system-update-tool)
Remove any leftover configuration files
Delete the repository list file
Update the package lists
Remove any unnecessary packages that might have been installed as dependencies



