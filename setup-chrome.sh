cd ~/Downloads
rm -f ~/Downloads/google-chrome-stable_current_amd64.deb*
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb


sudo dpkg -i ~/Downloads/google-chrome-stable_current_amd64.deb 
sudo apt-get install -y -f google-chrome-stable
