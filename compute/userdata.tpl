#!/bin/bash
yum install httpd -y
echo "subnet for firewall : ${firewall_subnets}" >> /var/www/html/index.html
service httpd start
chkconfig httpd on
