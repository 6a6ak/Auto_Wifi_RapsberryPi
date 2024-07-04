#!/bin/bash

# Define the file paths
WPA_FILE="/etc/wpa_supplicant/wpa_supplicant.conf"
BACKUP_WPA_FILE="/boot/wpa_supplicant.conf"

# Function to check if the file has write permissions
check_permissions() {
    if [ -w "$WPA_FILE" ]; then
        echo "The file $WPA_FILE is writable."
    else
        echo "The file $WPA_FILE is not writable."
    fi
}

# Function to make the file writable
make_writable() {
    sudo chmod u+w "$WPA_FILE"
    echo "The file $WPA_FILE is now writable."
}

# Function to update Wi-Fi credentials
update_credentials() {
    read -p "Enter your country code (e.g., US): " COUNTRY_CODE
    read -p "Enter your SSID: " SSID
    read -sp "Enter your password: " PASSWORD
    echo

    # Backup the original file
    sudo cp "$WPA_FILE" "$WPA_FILE.bak"

    # Replace the content of the file with the new credentials
    sudo bash -c "cat > $WPA_FILE" <<EOL
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
country=$COUNTRY_CODE

network={
    ssid="$SSID"
    psk="$PASSWORD"
    key_mgmt=WPA-PSK
}
EOL

    # Also update the backup file on the boot partition
    sudo bash -c "cat > $BACKUP_WPA_FILE" <<EOL
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
country=$COUNTRY_CODE

network={
    ssid="$SSID"
    psk="$PASSWORD"
    key_mgmt=WPA-PSK
}
EOL

    echo "Wi-Fi configuration updated successfully."
}

# Function to create a service to apply configuration on boot
create_service() {
    sudo bash -c "cat > /etc/systemd/system/apply-wifi-config.service" <<EOL
[Unit]
Description=Apply custom Wi-Fi configuration
After=network.target

[Service]
Type=oneshot
ExecStart=/usr/local/bin/apply-wifi-config.sh

[Install]
WantedBy=multi-user.target
EOL

    sudo bash -c "cat > /usr/local/bin/apply-wifi-config.sh" <<'EOL'
#!/bin/bash
cp /boot/wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant.conf
chmod 600 /etc/wpa_supplicant/wpa_supplicant.conf
EOL

    sudo chmod +x /usr/local/bin/apply-wifi-config.sh
    sudo systemctl enable apply-wifi-config.service
    echo "Service to apply Wi-Fi configuration on boot has been created and enabled."
}

# Function to display the menu
display_menu() {
    echo "Please choose an option:"
    echo "1. Check if the file has write permissions"
    echo "2. Make the file writable"
    echo "3. Update Wi-Fi credentials"
    echo "4. Create service to apply configuration on boot"
    echo "0. Exit"
}

# Main loop
while true; do
    display_menu
    read -p "Enter your choice [0-4]: " choice
    case $choice in
        1) check_permissions ;;
        2) make_writable ;;
        3) update_credentials ;;
        4) create_service ;;
        0) exit 0 ;;
        *) echo "Invalid option, please try again." ;;
    esac
done
