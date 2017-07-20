#!/bin/bash

#Remove libreoffice 
sudo apt-get -f -y remove --purge libreoffice*
sudo apt-get -f -y clean
sudo apt-get -f -y autoremove

#Download from the web
wget https://superb-sea2.dl.sourceforge.net/project/openofficeorg.mirror/4.1.3/binaries/en-US/Apache_OpenOffice_4.1.3_Linux_x86-64_install-deb_en-US.tar.gz

mv Apache_OpenOffice_4.1.3_Linux_x86-64_install-deb_en-US.tar.gz ~/Downloads/
cd ~/Downloads/

#Install the apache office suite
tar -xzvf Apache_OpenOffice_4.1.3_Linux_x86-64_install-deb_en-US.tar.gz
cd en-US/DEBS
sudo dpkg -i *.deb
cd desktop-integration
sudo dpkg -i *.deb
