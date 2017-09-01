# Jas copied from this URL on Spet 1, 2017

#http://www.instructables.com/id/Raspberry-Pi-Video-Streaming/

#Add the following line to the file /etc/apt/sources.list :

# sudo nano /etc/apt/sources.list

# deb http://www.linux-projects.org/listing/uv4l_repo/raspbian/ wheezy main
#     http://www.linux-projects.org/listing/uv4l_repo/raspbian/ jessie main 

# remove any uv4l repos that already exist
cat /etc/apt/sources.list | grep -v "http://www.linux-projects.org/listing/uv4l_repo/raspbian/" > /tmp/sources.list

# add the one that we want
echo http://www.linux-projects.org/listing/uv4l_repo/raspbian/ jessie main  >> /tmp/sources.list

# remove the old sources.list
sudo rm -Rf /etc/apt/sources.list

#put our modified sources.list back in place
sudo mv /tmp/sources.list /etc/apt/sources.list

$ sudo apt-get update

$ sudo apt-get upgrade

$ sudo apt-get install uv4l uv4l-raspicam

$ sudo apt-get install uv4l-raspicam-extras

$ sudo apt-get install uv4l-server

$ sudo apt-get install uv4l-uvc

$ sudo apt-get install uv4l-xscreen

$ sudo apt-get install uv4l-mjpegstream

$ sudo reboot
