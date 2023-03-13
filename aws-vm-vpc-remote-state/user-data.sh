#!/bin/bash
# apache teste terraform userdata
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
echo "Hello World from Terraform" | sudo tee /var/www/html/index.html
