# Nginx Auth

Set up Nginx for basic http/https authentication

In conjunction with rosbridge_server, this allows us to "securely" teleop from anywhere

Future work should include:

- https support
- oauth instead of username/pw
- run nginx on a separate machine

## Step 1: Install Nginx

Make sure to review install.sh and nginx_default for any username and IP address changes

```bash
# On your local machine
./cloud/vm/gcpvm.sh ssh
# On the VM
./cloud/nginx/install.sh
```

## Step 2: Adjust Firewall Rules

You need to create firewall rules that allow the VM to accept HTTP and HTTPS traffic

```bash
./http_firewall.sh
```
