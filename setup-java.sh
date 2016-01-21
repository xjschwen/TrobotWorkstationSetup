#!/bin/bash
# Download and untar the file in /opt
# this is good for setup of linux virtural boxes
# or other Linux

# 
curdir=$(readlink -m $HOME)
installroot="/opt/java"
javaInstaller="jdk-8u65-linux-x64.tar.gz"
downloadDir="$curdir/Downloads"
jdkName="jdk1.8.0_65"

mkdir -p "$downloadDir"
sudo mkdir -p "$installroot"
#change to downloadDir 
pushd "$downloadDir"


#If not already downloaded download it
if [ ! -f "$javaInstaller" ] ; then
	#http://download.oracle.com/otn-pub/java/jdk/8u65-b17/jdk-8u65-linux-x64.tar.gz
	wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u65-b17/$javaInstaller
	ls -l "jdk*"
else
	echo "Java Installer found, Not downloading it"
fi

sudo mkdir -p "$installroot"
pwd
if [ ! -d ""$installroot/$jdkName"" ] ; then
	sudo tar -zxvf "$downloadDir/$javaInstaller"  -C "$installroot"
	sudo chown root:root "$installroot/$jdkName"
	sudo ln -fs $(readlink -f "$installroot/$jdkName") "$installroot/jdk1.8"
fi 

popd 

