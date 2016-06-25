#!/bin/bash


#Used to up date the workstation and install needed packages for Robot Used

sudo apt-get update

sudo apt-get -y update
sudo apt-get -y upgrade

sudo apt-get -yf install nmap
sudo apt-get -yf install git
sudo apt-get -yf install htop
sudo apt-get -yf install vim

#install dns look utils
sudo apt-get -y install dnsutils


 
