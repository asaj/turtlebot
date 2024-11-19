USERNAME="asaoines"
sudo apt update
sudo apt install nginx
sudo apt-get install apache2-utils
sudo htpasswd -c /etc/nginx/.htpasswd $USERNAME
cp ./nginx_default /etc/nginx/sites-available/default
sudo nginx -t
sudo systemctl reload nginx
