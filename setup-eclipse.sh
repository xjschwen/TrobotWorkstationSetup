# Download and untar the file in /opt
# this is good for setup of linux virtural boxes
# or other Linux


# 
curdir=$(readlink -m $HOME)
installroot="/opt"
eclipseInstaller="eclipse-jee-mars-1-linux-gtk-x86_64.tar.gz"
downloadDir="$curdir/Downloads"

mkdir -p "$downloadDir"
sudo mkdir -p "$installroot"
#change to downloadDir 
pushd "$downloadDir"


#If not already downloaded download it
if [ ! -f "$eclipseInstaller" ] ; then
	#https://eclipse.org/downloads/packages/release/Mars/M1
	wget "http://eclipse.mirror.rafal.ca/technology/epp/downloads/release/mars/1/$eclipseInstaller"  
	ls -l 
else
	echo "Eclipse Installer found, Not downloading it"
fi

sudo mkdir -p "$installroot"
pwd
sudo tar -zxvf "$downloadDir/$eclipseInstaller"  -C "$installroot"
popd 






