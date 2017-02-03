#!/bin/bash

sudo mv nginx.conf /etc/nginx/sites-available/fullstack

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6
sudo mv mongodb-org-3.4.list /etc/apt/sources.list.d/

sudo apt-get update
sudo apt-get install -y build-essential openssl libssl-dev pkg-config


sudo apt-get install -y npm
sudo npm cache clean -f

sudo npm install -g -y n pm2
sudo n stable


sudo apt-get install -y nginx
sudo apt-get install -y git

sudo git clone https://github.com/globedasher/fullstack /var/www/fullstack
# I need to install node_modules and bower_components after this step

cd /var/www/fullstack
sudo npm install -y
sudo bower install --allow-root

sudo rm /etc/nginx/sites-available/default
sudo rm /etc/nginx/sites-enabled/default

sudo ln -s /etc/nginx/sites-available/fullstack /etc/nginx/sites-enabled/fullstack

sudo apt-get update
sudo apt-get install -y mongodb-org
sudo service mongod start

cd /var/www/fullstack
pm2 start server.js
sudo service nginx reload && sudo service nginx restart
echo "Complete. Please check all components installed properly."
