#!/bin/bash

sudo apt-get update
sudo apt-get install -y build-essential openssl libssl-dev pkg-config


sudo apt-get install npm
sudo npm cache clean -f

sudo npm install -g n pm2
sudo n stable


sudo apt-get install nginx
sudo apt-get install git

sudo git clone https://github.com/globedasher/fullstack /var/www/fullstack


sudo rm /etc/nginx/sites-available/default
sudo rm /etc/nginx/sites-enabled/default

sudo mv nginx.conf /etc/nginx/sites-available/fullstack

sudo ln -s /etc/nginx/sites-available/fullstack /etc/nginx/sites-enabled/fullstack

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6

sudo mv mongodb-org-3.4.list /etc/apt/sources.list.d/
sudo apt-get update
sudo apt-get install -y mongodb-org
sudo service mongodb start

cd /var/www/fullstack
sudo service mongod restart
pm2 start server.js
sudo service nginx reload && sudo service nginx restart
