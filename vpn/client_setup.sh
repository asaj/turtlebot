#!/bin/bash

# Variables
source ./vars.sh
SERVER_PUBLIC_KEY=""
CLIENT_PRIVATE_KEY=""
CLIENT_PUBLIC_KEY=""
SERVER_ENDPOINT=""

# Install WireGuard
echo "Installing WireGuard..."
sudo apt update
sudo apt install -y wireguard

# Generate WireGuard keys for the client
echo "Generating WireGuard keys..."
CLIENT_PRIVATE_KEY=$(wg genkey)
CLIENT_PUBLIC_KEY=$(echo "$CLIENT_PRIVATE_KEY" | wg pubkey)

# Prompt for server's public key and endpoint
read -p "Enter the server's public key: " SERVER_PUBLIC_KEY
read -p "Enter the server's endpoint (IP:PORT): " SERVER_ENDPOINT

# Create the WireGuard configuration file
echo "Creating WireGuard configuration..."
sudo bash -c "cat > $WG_CONFIG" <<EOL
[Interface]
Address = $CLIENT_VPN_IP
PrivateKey = $CLIENT_PRIVATE_KEY

[Peer]
PublicKey = $SERVER_PUBLIC_KEY
Endpoint = $SERVER_ENDPOINT
AllowedIPs = $SERVER_VPN_IP
PersistentKeepalive = 25
EOL

# Start and enable WireGuard
echo "Starting WireGuard..."
sudo systemctl start wg-quick@$WG_INTERFACE
sudo systemctl enable wg-quick@$WG_INTERFACE

# Output the client's public key for the server
echo "WireGuard client setup complete."
echo "Client Public Key: $CLIENT_PUBLIC_KEY"
echo "Provide this key to the server to finalize the setup."
