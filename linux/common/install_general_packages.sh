#!/bin/bash
err_report() {
    echo "Error on line $1"
    exit 1
}

trap 'err_report $LINENO' ERR
#Used to up date the workstation and install needed packages for Robot Use

 apt-get update
 apt-get upgrade

 apt-get install --yes --fix-broken nmap
 apt-get install --yes --fix-broken gcc
 apt-get install --yes --fix-broken inetutils-traceroute
 apt-get install --yes --fix-broken tcptrack
 apt-get install --yes --fix-broken git gitk gitg
 apt-get install --yes --fix-broken htop
 apt-get install --yes --fix-broken vim

 apt-get install --yes --fix-broken build-essential
 apt-get install --yes --fix-broken cmake
 apt-get install --yes --fix-broken pkg-config
 apt-get install --yes --fix-broken terminator
 apt-get install --yes --fix-broken ant
 apt-get install --yes --fix-broken groovy
 apt-get install --yes --fix-broken gradle
 apt-get install --yes --fix-broken cmake


#install dns look utils
 apt-get install --yes --fix-broken dnsutils

 apt-get --yes autoremove
