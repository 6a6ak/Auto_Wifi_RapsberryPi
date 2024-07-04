# Wi-Fi Configuration Script for Raspberry Pi

This repository contains a bash script to configure Wi-Fi settings on a Raspberry Pi. The script automates the process of updating the `wpa_supplicant.conf` file with the necessary credentials and ensures the file is correctly permissioned for secure operation.

## Features

- Checks if the `wpa_supplicant.conf` file is writable.
- Makes the file writable if it is not.
- Prompts the user for country code, SSID, and password.
- Updates the `wpa_supplicant.conf` file with the provided credentials.
- Sets the file back to read-only to protect the credentials.
- Backs up the original configuration file before making changes.

## Prerequisites

- A Raspberry Pi with Raspbian OS installed.
- Basic knowledge of using the terminal and running bash scripts.

## Installation

1. Clone this repository to your Raspberry Pi:
    ```sh
    git clone https://github.com/6a6ak/wifi-config-script.git
    cd wifi-config-script
    ```

2. Make the script executable:
    ```sh
    chmod +x configure_wifi.sh
    ```

## Usage

1. Run the script with superuser privileges:
    ```sh
    sudo ./configure_wifi.sh
    ```

2. Follow the prompts to enter your country code, SSID, and password.

3. The script will automatically update the `wpa_supplicant.conf` file and set it to read-only.

## Example

```sh
sudo ./configure_wifi.sh
