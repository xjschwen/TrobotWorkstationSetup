#!/bin/bash
err_report() {
    echo "Error on line $1"
    exit 1
}

trap 'err_report $LINENO' ERR

pushd ~/Downloads

rm -f ~/Downloads/google-chrome-stable_current_amd64.deb*
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb  
sudo dpkg -i google-chrome-stable_current_amd64.deb 
sudo apt-get install -y -f google-chrome-stable
popd

cp google-chrome.desktop ~/Desktop/google-chrome.desktop
