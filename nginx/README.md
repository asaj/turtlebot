# Nginx Auth

Set up Nginx for basic http/https authentication

In conjunction with rosbridge_server, this allows us to "securely" teleop from anywhere

Future work should include:

- https support
- oauth instead of username/pw
- run nginx on a separate machine

## Step 1: Set up Nginx

Make sure to review nginx_setup.sh and nginx_default for any username and IP address changes

```bash
# On the VM
./nginx/nginx_setup.sh
```

## Step 2: Adjust Firewall Rules

You need to create firewall rules that allow the VM to accept HTTP and HTTPS traffic

```bash
# On your local machine, in the ros-vm repo
cd ~/ros-vm
./nginx_firewall.sh
```
