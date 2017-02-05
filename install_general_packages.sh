#!/bin/bash

#Used to up date the workstation and install needed packages for Robot Used

sudo apt-get -y update
sudo apt-get -y upgrade

sudo apt-get -yf install oracle-java8-jdk
sudo apt-get -yf install nmap
sudo apt-get -yf install inetutils-traceroute
sudo apt-get -yf install tcptrack
sudo apt-get -yf install git
sudo apt-get -yf install htop
sudo apt-get -yf install vim

sudo apt-get -y install build-essential
sudo apt-get -y install cmake
sudo apt-get -y install pkg-config

#install dns look utils
sudo apt-get -y install dnsutils
