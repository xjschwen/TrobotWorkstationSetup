set -o errtrace
trap 'printerr' ERR
function printerr(){
 local lc="$BASH_COMMAND" rc=$? ln=${BASH_LINENO[$i]}
 echo "$(date +%s) : Command [ $lc ] exited with code [ $rc ] in line [ $ln ]"
 exit $rc
}


# Jas copied from this URL on Spet 1, 2017
#https://www.linux-projects.org/uv4l/installation/

#Add the following line to the file /etc/apt/sources.list :

tmp_sources='/tmp/sources.list'
apt_sources='/etc/apt/sources.list'

#add the key to key-ring

curl http://www.linux-projects.org/listing/uv4l_repo/lrkey.asc | sudo apt-key add -

# remove any uv4l repos that already exist
cat ${apt_sources} | grep -v "http://www.linux-projects.org/listing/uv4l_repo/raspbian/" > ${tmp_sources} || true

jessie="$(cat /etc/apt/sources.list  | grep -c jessie || true)"
wheezy="$(cat /etc/apt/sources.list  | grep -c wheezy || true)"
stretch="$(cat /etc/apt/sources.list | grep -c stretch || true)"

if [ ${jessie} > 0  ] ; then
   newline="deb http://www.linux-projects.org/listing/uv4l_repo/raspbian/ jessie main"
elif [ ${wheezy} > 0  ] ; then
   newline="deb http://www.linux-projects.org/listing/uv4l_repo/raspbian/ wheezy main"
elif [ ${stretch} ] ; then
   newline="deb http://www.linux-projects.org/listing/uv4l_repo/raspbian/stretch stretch main"
else
   echo "Unsupported PI operating system."
   exit 1
fi


# add the one that we want
echo ${newline} >> ${tmp_sources}

# remove the old sources.list
sudo rm -Rf ${apt_sources}

#put our modified sources.list back in place
sudo mv ${tmp_sources} ${apt_sources}
sudo chown root:root ${apt_sources}

sudo apt-get update
sudo apt-get upgrade

sudo raspi-config nonint do_camera 1
sudo raspi-config nonint do_i2c 1

sudo apt-get install -f -y uv4l
sudo apt-get install -f -y uv4l-raspicam
sudo apt-get install -f -y uv4l-raspicam-extras
#sudo apt-get install -f -y uv4l-tc358743-extras
sudo apt-get install -f -y v4l-utils
sudo apt-get install -f -y uv4l-server
#sudo apt-get install -f -y uv4l-uvc   # usb style camera
#sudo apt-get install -f -y uv4l-xscreen
#sudo apt-get install -f -y uv4l-mjpegstream
#sudo apt-get install -f -y uv4l-dummy      # dummy ?
#sudo apt-get install -f -y uv4l-raspidisp  # HDMI style camera

sudo service uv4l_raspicam restart

#sudo cp ./start-uv4l-video-stream.sh /usr/local/bin/start-uv4l-video-stream.sh

#sudo chmod 755 /usr/local/bin/start-uv4l-video-stream.sh

sudo systemctl enable uv4l_raspicam.service

sudo rm -f /etc/uv4l/uv4l-raspicam.conf
sudo cp ./uv4l-raspicam.conf /etc/uv4l/uv4l-raspicam.conf
sudo service uv4l_raspicam restart
