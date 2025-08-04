#!/bin/bash
# Exit immediately if a command exits with a non-zero status.
set -e

# Use apt-get for scripting to avoid interactive prompts and unstable CLI warnings
sudo apt-get update -y
sudo apt-get install -y apache2
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
