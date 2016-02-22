# setup a video stream web server on RPi for FRC


# update the PI

sudo apt-get -y update
sudo apt-get -y upgrade

# Install motion and needed libs
sudo apt-get -y install motion
sudo apt-get -y install libjpeg62

# Install lighttpd to run the web page
sudo apt-get -y install lighttpd

#install cli edit tools vim 
sudo apt-get -y install vim

#Install some network tools 
sudo apt-get -y install htop
sudo apt-get -y install nmap


#configure lighttpd options
sudo lighttpd-enable-mod userdir
#For example, the user "joe" would put his files in 
#"/home/joe/public_html" and access them at "http://serverip/~joe".


#Reload the lighttpd configs
sudo service lighttpd reload

#Make the pi public_html and give it to pi user
sudo mkdir -p "/home/pi/public_html"
sudo chown pi:pi "/home/pi/public_html"
