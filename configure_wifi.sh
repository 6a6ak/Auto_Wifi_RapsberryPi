#!/bin/bash

# Define the file path
WPA_FILE="/etc/wpa_supplicant/wpa_supplicant.conf"

# 1. Check if the file has write permissions
if [ -w "$WPA_FILE" ]; then
    echo "The file $WPA_FILE is writable."
else
    echo "The file $WPA_FILE is not writable. Changing permissions..."
    sudo chmod u+w "$WPA_FILE"
fi

# 2. Ensure the file is writable for editing
sudo chmod u+w "$WPA_FILE"

# 3. Ask for the necessary variables
read -p "Enter your country code (e.g., US): " COUNTRY_CODE
read -p "Enter your SSID: " SSID
read -sp "Enter your password: " PASSWORD
echo

# Backup the original file
sudo cp "$WPA_FILE" "$WPA_FILE.bak"

# 4. Replace the content of the file with the new credentials
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

echo "Wi-Fi configuration updated successfully."

# 5. Make the file read-only
sudo chmod u-w "$WPA_FILE"

echo "The file $WPA_FILE is now read-only."

# 6. Exit
exit 0
