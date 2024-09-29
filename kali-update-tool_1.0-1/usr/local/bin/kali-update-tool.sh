#!/bin/bash

# Define colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to print colored output
print_color() {
    echo -e "${1}${2}${NC}"
}

# Check if running with sudo
if [ "$EUID" -ne 0 ]; then 
    print_color $RED "Please run as root or with sudo."
    exit 1
fi

# Install required packages
print_color $GREEN "Installing required packages..."
apt-get update
apt-get install -y zenity

# Create the update script
print_color $GREEN "Creating update script..."
cat > /usr/local/bin/system-update.sh << EOL
#!/bin/bash

# Function to update the progress bar
update_progress() {
    local percent=\$1
    echo "\$percent"
    echo "# \$2"
}

# Function to verify sudo password
verify_sudo() {
    local password=\$1
    echo \$password | sudo -S -v 2>/dev/null
    return \$?
}

# Function to run update and upgrade with progress bar
run_update_upgrade() {
    # Use zenity to create a password dialog
    password=\$(zenity --password --title="System Update")

    # Check if user cancelled the password dialog
    if [ \$? -ne 0 ]; then
        zenity --error --text="Update cancelled." --title="System Update"
        exit 1
    fi

    # Verify the password
    if ! verify_sudo "\$password"; then
        zenity --error --text="Incorrect password. Update cancelled." --title="System Update"
        exit 1
    fi

    # Run update and upgrade commands with progress bar
    (
        update_progress 0 "Starting system update..."
        echo \$password | sudo -S apt update 2>&1 | tee /tmp/apt_output.log | while read line; do
            if [[ \$line == *"Reading package lists"* ]]; then
                update_progress 25 "Updating package lists..."
            fi
        done

        update_progress 50 "Upgrading packages..."
        echo \$password | sudo -S apt upgrade -y 2>&1 | tee -a /tmp/apt_output.log | while read line; do
            if [[ \$line == *"Unpacking"* ]]; then
                update_progress 75 "Unpacking packages..."
            elif [[ \$line == *"Setting up"* ]]; then
                update_progress 90 "Setting up packages..."
            fi
        done

        update_progress 100 "Update complete!"
    ) | zenity --progress \\
              --title="System Update" \\
              --text="Starting system update..." \\
              --percentage=0 \\
              --auto-close \\
              --auto-kill

    # Check if the update was successful
    if [ \$? -eq 0 ]; then
        zenity --info --text="Update and upgrade completed successfully!" --title="System Update"
    else
        zenity --error --text="Update and upgrade failed. Please check the log file at /tmp/apt_output.log for errors." --title="System Update"
    fi
}

# Run the function
run_update_upgrade
EOL

# Make the script executable
chmod +x /usr/local/bin/system-update.sh

# Create desktop entry
print_color $GREEN "Creating desktop entry..."
cat > /usr/share/applications/system-update.desktop << EOL
[Desktop Entry]
Type=Application
Name=System Update
Comment=Run system update and upgrade with progress bar
Exec=/usr/local/bin/system-update.sh
Icon=system-software-update
Terminal=false
Categories=System;
EOL

print_color $GREEN "Installation complete. You should now see 'System Update' in your applications menu."
