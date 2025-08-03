#$bin/bash
sudo apt update -y
sudo apt install apache2 -y
sudo systectl start apache2
sudo systemctl enable apache2
cd /var/www/html 
sudo chmod 755 /var/www/html
sudo touch index.html 
echo "hello world" > index.html 
