#!/bin/bash
# Download and untar the file in /opt
# this is good for setup of linux virtural boxes
# or other Linux

#

if [ "$(cat /proc/cpuinfo | grep "ARMv7")"  > "0" ] ; then
  #Yes it is that easy for Raspberry PI
	sudo apt-get install -yf oracle-java8-jdk
	exit $?
fi

curdir=$(readlink -m $HOME)
installroot="/opt/java"
javaInstaller="jdk-8u111-linux-x64.tar.gz"
downloadDir="$curdir/Downloads"
jdkName="jdk1.8.0_111"

mkdir -p "$downloadDir"
sudo mkdir -p "$installroot"
#change to downloadDir
pushd "$downloadDir"


#If not already downloaded download it
if [ ! -f "$javaInstaller" ] ; then
	#http://download.oracle.com/otn-pub/java/jdk/8u111-b14/jdk-8u111-linux-x64.tar.gz
	wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u111-b14/$javaInstaller
	ls -l "jdk*"
else
	echo "Java Installer found, Not downloading it"
fi

sudo mkdir -p "$installroot"
pwd
#if [ ! -d ""$installroot/$jdkName"" ] ; then
	pushd $installroot
	sudo tar -zxvf "$downloadDir/$javaInstaller"  -C "$installroot"
	sudo chown root:root "$installroot/$jdkName"
  sudo rm -Rf $installroot/jdk1.8
	sudo ln -fs $(readlink -f "$jdkName") "jdk1.8"
#fi

popd
