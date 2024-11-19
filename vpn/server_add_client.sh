#!/bin/bash

# Variables
source ./vars.sh
CLIENT_PUBLIC_KEY=""

# Prompt for the client's public key and VPN IP
read -p "Enter the client's public key: " CLIENT_PUBLIC_KEY

# Check if the WireGuard configuration file exists
if [[ ! -f "$WG_CONFIG" ]]; then
    echo "Error: WireGuard configuration file $WG_CONFIG does not exist."
    exit 1
fi

# Add the client's public key to the WireGuard configuration
echo "Adding client to WireGuard configuration..."
sudo bash -c "cat >> $WG_CONFIG" <<EOL

[Peer]
PublicKey = $CLIENT_PUBLIC_KEY
AllowedIPs = $CLIENT_VPN_IP
EOL

# Restart WireGuard to apply changes
echo "Restarting WireGuard..."
sudo systemctl restart wg-quick@wg0

echo "Client added successfully."
