# setup a video stream web server on RPi for FRC


# update the PI
sudo apt-get -Y update
sudo apt-get -Y upgrade

# Install motion and needed libs
sudo apt-get install -Y motion
sudo apt-get install -Y libjpeg62

# Install lighttpd to run the web page
sudo apt-get install -y lighttpd

#install cli edit tools vim 
sudo apt-get install -Y vim

#Install some network tools 
sudo apt-get install -Y htop
sudo apt-get install -y nmap


