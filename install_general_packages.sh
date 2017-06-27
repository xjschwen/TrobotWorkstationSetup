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

#install dns look utils
sudo apt-get -y install dnsutils

cp terminator.desktop ~/Desktop/terminator.desktop
cp gedit.desktop ~/Desktop/gedit.desktop
cp gitg.desktop ~/Desktop/gitg.desktop

