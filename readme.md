# Wi-Fi Configuration Script for Raspberry Pi

This repository contains a bash script to configure Wi-Fi settings on a Raspberry Pi. The script automates the process of updating the `wpa_supplicant.conf` file with the necessary credentials and ensures the file is correctly permissioned for secure operation.

## Features

- Check if the `wpa_supplicant.conf` file is writable.
- Make the file writable if it is not.
- Prompt the user for country code, SSID, and password.
- Update the `wpa_supplicant.conf` file and create a backup on the boot partition.
- Create a service to apply the configuration on every boot to ensure persistence.
- Menu-driven interface for easy use.

## Prerequisites

- A Raspberry Pi with Raspbian OS installed.
- Basic knowledge of using the terminal and running bash scripts.

## Installation

1. Clone this repository to your Raspberry Pi:
    ```sh
    git clone https://github.com/6a6ak/Auto_Wifi_RapsberryPi.git
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

2. Follow the prompts to choose an option from the menu:
    - **1**: Check if the file has write permissions.
    - **2**: Make the file writable.
    - **3**: Update Wi-Fi credentials.
    - **4**: Create a service to apply the configuration on boot.
    - **0**: Exit the script.

## Example

```sh
sudo ./configure_wifi.sh
