#!/bin/bash
err_report() {
    echo "Error on line $1"
}

trap 'err_report $LINENO' ERR

#Used to up date the workstation and install needed packages for Robot Use

sudo apt-get -y update
sudo apt-get -y upgrade

sudo apt-get -yf install nmap
sudo apt-get -yf install inetutils-traceroute
sudo apt-get -yf install tcptrack
sudo apt-get -yf install git gitk gitg
sudo apt-get -yf install htop
sudo apt-get -yf install vim

sudo apt-get -yf install build-essential
sudo apt-get -yf install cmake
sudo apt-get -yf install pkg-config
sudo apt-get -yf install terminator
sudo apt-get -yf install ant
sudo apt-get -yf install groovy
sudo apt-get -yf install gradle
sudo apt-get -yf install cmake



#install dns look utils
sudo apt-get -y install dnsutils


if [ "$(cat /proc/cpuinfo | grep -c "ARMv")"  == "0" ] ; then
  cp terminator.desktop ~/Desktop/terminator.desktop
  cp gedit.desktop ~/Desktop/gedit.desktop
  cp gitg.desktop ~/Desktop/gitg.desktop
else
  echo "We are on a ARM Processeor... There is no desktop!"
fi


