#!/bin/bash
err_report() {
    echo "Error on line $1"
    exit 1
}

trap 'err_report $LINENO' ERR
#Used to up date the workstation and install needed packages for Robot Use

 sudo apt-get update
 sudo apt-get upgrade

 sudo apt-get install --yes --fix-broken nmap
 sudo apt-get install --yes --fix-broken gcc
 sudo apt-get install --yes --fix-broken inetutils-traceroute
 sudo apt-get install --yes --fix-broken tcptrack
 sudo apt-get install --yes --fix-broken git gitk gitg
 sudo apt-get install --yes --fix-broken htop
 sudo apt-get install --yes --fix-broken vim

 sudo apt-get install --yes --fix-broken build-essential
 sudo apt-get install --yes --fix-broken cmake
 sudo apt-get install --yes --fix-broken pkg-config
 sudo apt-get install --yes --fix-broken terminator
 sudo apt-get install --yes --fix-broken ant
 sudo apt-get install --yes --fix-broken groovy
 sudo apt-get install --yes --fix-broken gradle
 sudo apt-get install --yes --fix-broken cmake


#install dns look utils
 sudo apt-get install --yes --fix-broken dnsutils

 sudo apt-get --yes autoremove
