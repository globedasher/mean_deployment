#!/bin/bash

# Add the key and move a sources list into the apt directory to add access to
# the MongoDB repositories for Ubuntu.
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6
sudo mv mongodb-org-3.4.list /etc/apt/sources.list.d/

# Update and install all needed applications.
sudo apt-get update
sudo apt-get install -y build-essential \
			openssl 	\
			libssl-dev 	\
			pkg-config 	\
			tmux 		\
			htop 		\
			tree 		\
			nginx 		\
			git 		\
			npm		\
			mongodb-org	\

# Clean npm cache
sudo npm cache clean -f

# Install n, project manager and bower globally
sudo npm install -g -y n pm2 bower
# And latest version of node
sudo n stable

echo"Installs complete. Moving on to configuration..."

# Move the nginx configuration file to the sites available/{{ PROJECT_NAME}}
# location
sudo mv nginx.conf /etc/nginx/sites-available/fullstack

# Clone MEAN project from github location to /var/www/{{ PROJECT_NAME }}
sudo git clone https://github.com/globedasher/fullstack /var/www/fullstack

# Move to the project file and install project dependencies
cd /var/www/fullstack
sudo npm install -y
sudo bower install --allow-root

# Remove nginx default site files.
sudo rm /etc/nginx/sites-available/default
sudo rm /etc/nginx/sites-enabled/default

# Create symlink to newly avaible project.
sudo ln -s /etc/nginx/sites-available/fullstack /etc/nginx/sites-enabled/fullstack

# Ensure mongod is started.
sudo service mongod start

# Move to the project directory and start the project.
cd /var/www/fullstack
pm2 start server.js
# Reload and restart nginx.
sudo service nginx reload && sudo service nginx restart
echo "Complete. Please check all components installed properly."
