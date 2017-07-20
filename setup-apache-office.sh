#!/bin/bash

#Remove libreoffice 
sudo apt-get -y remove --purge libreoffice*
sudo apt-get -y clean
sudo apt-get -y autoremove

cd ~/Downloads/

# if we already have the file do not waste time downloading it again.
#Download from the web
if [ ! -f Apache_OpenOffice_4.1.3_Linux_x86-64_install-deb_en-US.tar.gz ] ; then
	wget https://superb-sea2.dl.sourceforge.net/project/openofficeorg.mirror/4.1.3/binaries/en-US/Apache_OpenOffice_4.1.3_Linux_x86-64_install-deb_en-US.tar.gz
fi

#Install the apache office suite
tar -xzvf Apache_OpenOffice_4.1.3_Linux_x86-64_install-deb_en-US.tar.gz
cd en-US/DEBS
sudo dpkg -i *.deb
cd desktop-integration
sudo dpkg -i *.deb

#perform some cleanup
rm -Rf ~/Downloads/en-US/
