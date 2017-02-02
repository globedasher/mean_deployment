#!/bin/zsh

sudo apt-get update
sudo apt-get install -y build-essential openssl libssl-dev pkg-config


sudo apt-get install npm
sudo npm cache clean -f

sudo npm install -g n pm2
sudo n stable


sudo apt-get install nginx
sudo apt-get install git

cd /var/www/
git clone https://github.com/globedasher/fullstack


sudo rm /etc/nginx/sites-available/default
sudo rm /etc/nginx/sites-enabled/default

echo"
server {
    listen 80;
    location / {
        proxy_pass http://{{ PRIVATE-IP }}:8000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}
" | sudo tee /etc/nginx/sites-available/fullstack

sudo ln -s /etc/nginx/sites-available/fullstack /etc/nginx/sites-enabled/fullstack

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6
echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.4.list
sudo apt-get update
sudo apt-get install -y mongodb-org
sudo service mongodb start

cd /var/www/fullstack
sudo service mongod restart
pm2 start server.js
sudo service nginx reload && sudo service nginx restart