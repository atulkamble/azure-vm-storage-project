#!/bin/bash
sudo apt update -y
sudo apt install apache2 -y
sudo systemctl start apache2
sudo systemctl enable apache2
cd /var/www/html 
sudo chmod 755 /var/www/html
sudo tee index.html > /dev/null <<EOF
<!DOCTYPE html>
<html>
<head>
    <title>Welcome Page</title>
</head>
<body>
    <h1 style="text-align: center;">Hello World</h1>
</body>
</html>
EOF
