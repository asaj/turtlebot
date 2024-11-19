#!/bin/bash

# Prompt the user for a username
read -p "Enter the username for Nginx authentication: " USERNAME

# Update and install necessary packages
echo "Updating package lists..."
sudo apt update

echo "Installing Nginx..."
sudo apt install -y nginx

echo "Installing Apache2 utilities for htpasswd..."
sudo apt-get install -y apache2-utils

# Create the htpasswd file and prompt for a password
echo "Setting up username and password for authentication..."
sudo htpasswd -c /etc/nginx/.htpasswd "$USERNAME"

# Copy the Nginx configuration
echo "Copying the Nginx configuration file..."
sudo cp ~/turtlebot/nginx/nginx_default /etc/nginx/sites-available/default

# Test Nginx configuration
echo "Testing Nginx configuration..."
sudo nginx -t

if [ $? -eq 0 ]; then
    echo "Nginx configuration is valid. Reloading Nginx..."
    sudo systemctl reload nginx
    echo "Nginx has been reloaded successfully."
else
    echo "Nginx configuration test failed. Please check your configuration file."
    exit 1
fi
