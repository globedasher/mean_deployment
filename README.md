The serverInit.sh script has been created to be run on a unix-like system that
runs bash shell scripts. The purpose is to deploy a MEAN application as
taught by Coding Dojo.

At this time, it only clones GitHub repos.

To use this script, once you have created an Ubuntu instance on your Amazon Web
Service, ssh into the instance and git clone this repository to your server.

cd mean_deployment

Edit the nginx.conf file. The {{ private-ip }} tag needs to be replaced with
your server private IP address.
(TODO: add an ifconfig call that can dynamically replace the {{ private-ip }})


./serverInit.sh to run this script and repond to requeses for GitHub user and
repo information. 

If you are not familiar with configuring a server manually, I suggest you do
so before using the shell script in case you need to troubleshoot the
deployment, but the point of using the script is to avoid any issues.

If deployment does not complete as expected, check if your project cloned
properly from GitHub.
