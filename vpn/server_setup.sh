#!/bin/bash

# Variables
source ./vars.sh
SERVER_PRIVATE_KEY=""
SERVER_PUBLIC_KEY=""
CLIENT_PUBLIC_KEY=""

# Install WireGuard
echo "Installing WireGuard..."
sudo apt update
sudo apt install -y wireguard

# Generate WireGuard keys for the server
echo "Generating WireGuard keys..."
SERVER_PRIVATE_KEY=$(wg genkey)
SERVER_PUBLIC_KEY=$(echo "$SERVER_PRIVATE_KEY" | wg pubkey)

# Create the WireGuard configuration file
echo "Creating WireGuard configuration..."
sudo bash -c "cat > $WG_CONFIG" <<EOL
[Interface]
Address = $SERVER_VPN_IP
ListenPort = $LISTEN_PORT
PrivateKey = $SERVER_PRIVATE_KEY
EOL

# Enable IP forwarding
echo "Enabling IP forwarding..."
sudo sysctl -w net.ipv4.ip_forward=1
echo "net.ipv4.ip_forward=1" | sudo tee -a /etc/sysctl.conf

# Set up firewall rules
echo "Configuring firewall rules..."
sudo ufw allow $LISTEN_PORT/udp
sudo ufw reload

# Start and enable WireGuard
echo "Starting WireGuard..."
sudo systemctl start wg-quick@$WG_INTERFACE
sudo systemctl enable wg-quick@$WG_INTERFACE

# Output the server's public key for the client
echo "WireGuard server setup complete."
echo "Server Public Key: $SERVER_PUBLIC_KEY"
echo "Provide this key to the client and ensure the client connects to this server's public IP on port $LISTEN_PORT."
