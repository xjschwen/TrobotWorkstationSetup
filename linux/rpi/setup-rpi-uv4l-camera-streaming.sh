# Jas copied from this URL on Spet 1, 2017

#http://www.instructables.com/id/Raspberry-Pi-Video-Streaming/

#Updated for use with the pi3 and stretch
#http://www.linux-projects.org/uv4l/installation/

#Add the following line to the file /etc/apt/sources.list :

# sudo nano /etc/apt/sources.list

# deb http://www.linux-projects.org/listing/uv4l_repo/raspbian/ wheezy main
#     http://www.linux-projects.org/listing/uv4l_repo/raspbian/ jessie main

tmp_sources='/tmp/sources.list'
apt_sources='/etc/apt/sources.list'

#add the key to key-ring

curl http://www.linux-projects.org/listing/uv4l_repo/lpkey.asc | sudo apt-key add -
# remove any uv4l repos that already exist
cat ${apt_sources} | grep -v "http://www.linux-projects.org/listing/uv4l_repo/raspbian/" > ${tmp_sources}

# add the one that we want
echo deb http://www.linux-projects.org/listing/uv4l_repo/raspbian/stretch stretch main  >> ${tmp_sources}

# remove the old sources.list
sudo rm -Rf ${apt_sources}

#put our modified sources.list back in place
sudo mv ${tmp_sources} ${apt_sources}

sudo apt-get update
sudo apt-get upgrade

sudo apt-get install uv4l uv4l-raspicam
sudo apt-get install uv4l-raspicam-extras
sudo apt-get install uv4l-server
sudo apt-get install uv4l-uvc
sudo apt-get install uv4l-xscreen
sudo apt-get install uv4l-mjpegstream

sudo cp start-uv4l-video-stream.sh /usr/local/bin/start-uv4l-video-stream.sh
sudo chmod 755 /usr/local/bin/start-uv4l-video-stream.sh

sudo systemctl enable uv4l.service

echo "Rebooting in 10 seconds"
sleep 10
sudo reboot
