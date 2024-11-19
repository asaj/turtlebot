# turtlebot

## 1. Set up VPN
We use a VPN server running on a GCP VM and a client running on the turtlebot.

Create a VM using the ros2-vm repo.
```bash
# Create a GCP VM and configure it for Chrome Remote Desktop
./vm.sh create
# Create a firewall rule to allow the VM to run as a VPN server
./firewall.sh
# SSH into the VM and clone the this repo
# You may need to follow the ros2-vm readme to configure an ssh key
./vm.sh ssh
git clone turtlebot
```

Setup the VPN server on the VM
```bash
sudo bash server_setup.sh
```

Setup the VPN client on the turtlebot
```bash
ssh turtlebot
sudo bash client_setup.sh
```

On the VM, add the VPN client to the server
```bash
sudo bash server_add_client.sh
```

Test things out by pinging the VPN IPs from the client to server and vice versa

## 2. Set up a discovery server
We run ROS using a fast DDS discovery server so that we can have ROS nodes discovery each other on different networks.

It might feel more intuitive to set up the discovery server on the VM, which is what I tried to do initially, but it would require setting up a VPN client on the create3 as well and I wanted to avoid monkeying with the create3 as best I could. 

Follow the instructions here:
https://turtlebot.github.io/turtlebot4-user-manual/setup/discovery_server.html

For the "User PC" section, use the VPN IP of the turtlebot.
