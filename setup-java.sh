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
               
javaInstaller="jdk-8u131-linux-x64.tar.gz"
downloadDir="$curdir/Downloads"
jdkName="jdk1.8.0_131"

mkdir -p "$downloadDir"
sudo mkdir -p "$installroot"
#change to downloadDir
pushd "$downloadDir"

http:/download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.tar.gz?AuthParam=1496603682_086e58a243853313e120e1befe758678

#If not already downloaded download it
if [ ! -f "$javaInstaller" ] ; then
	#http:/download.oracle.com/otn-pub/java/jdk/8u111-b14/jdk-8u131-linux-x64.tar.gz
	wget --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" http:/download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.tar.gz
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
  sudo rm -Rf $installroot/jdk1.8.0_131
	sudo ln -fs $(readlink -f "$jdkName") "jdk1.8.0_131"
#fi

popd

sudo rm -f /etc/alternatives/java
sudo ln -sf /opt/java/jdk1.8.0_131/jre/bin/java /etc/alternatives/java 

sudo rm -f /etc/alternatives/javaws
sudo ln -sf /opt/java/jdk1.8.0_131/jre/bin/javaws /etc/alternatives/javaws 

sudo rm -f /etc/alternatives/javaws.1*
sudo ln -sf /opt/java/jdk1.8.0_131/jre/bin/javaws.1 /etc/alternatives/javaws.1 

sudo rm -f /etc/alternatives/jexec
sudo ln -sf /opt/java/jdk1.8.0_131/jre/lib/jexec /etc/alternatives/jexec

sudo rm -f /etc/alternatives/keytool
sudo ln -sf /opt/java/jdk1.8.0_131/jre/bin/keytool /etc/alternatives/keytool

sudo rm -f /etc/alternatives/keytool.1*
sudo ln -sf /opt/java/jdk1.8.0_131/jre/man/man1/keytool.1 /etc/alternatives/keytool.1

sudo rm -f /etc/alternatives/orbd
sudo ln -sf /opt/java/jdk1.8.0_131/jre/bin/orbd /etc/alternatives/orbd
sudo rm -f /etc/alternatives/orbd.1*
sudo ln -sf /opt/java/jdk1.8.0_131/jre/man/man1/orbd.1 /etc/alternatives/orbd.1

sudo rm -f /etc/alternatives/pack200
sudo ln -sf  /opt/java/jdk1.8.0_131/jre/bin/pack200 /etc/alternatives/pack200
sudo rm -f /etc/alternatives/pack200.1*
sudo ln -sf  /opt/java/jdk1.8.0_131/jre/man/man1/pack200.1 /etc/alternatives/pack200.1

sudo rm -f /etc/alternatives/policytool
sudo ln -sf /opt/java/jdk1.8.0_131/jre/bin/policytool /etc/alternatives/policytool
sudo rm -f /etc/alternatives/policytool.1*
sudo ln -sf /opt/java/jdk1.8.0_131/jre/man/man1/policytool.1 /etc/alternatives/policytool.1

sudo rm -f /etc/alternatives/rmid
sudo ln -sf /opt/java/jdk1.8.0_131/jre/bin/rmid  /etc/alternatives/rmid
sudo rm -f /etc/alternatives/rmid.1*
sudo ln -sf /opt/java/jdk1.8.0_131/jre/man/man1/rmid.1 /etc/alternatives/rmid.1

sudo rm -f /etc/alternatives/rmiregistry
sudo ln -sf /opt/java/jdk1.8.0_131/jre/bin/rmiregistry /etc/alternatives/rmiregistry
sudo rm -f /etc/alternatives/rmiregistry.1*
sudo ln -sf /opt/java/jdk1.8.0_131/jre/man/man1/rmiregistry.1 /etc/alternatives/rmiregistry.1

sudo rm -f /etc/alternatives/servertool
sudo ln -sf /opt/java/jdk1.8.0_131/jre/bin/servertool /etc/alternatives/servertool
sudo rm -f /etc/alternatives/servertool.1*
sudo ln -sf /opt/java/jdk1.8.0_131/jre/man/man1/servertool.1 /etc/alternatives/servertool.1

sudo rm -f /etc/alternatives/tnameserv
sudo ln -sf /opt/java/jdk1.8.0_131/jre/bin/tnameserv /etc/alternatives/tnameserv
sudo rm -f /etc/alternatives/tnameserv.1*
sudo ln -sf /opt/java/jdk1.8.0_131/jre/man/man1/tnameserv.1 /etc/alternatives/tnameserv.1

sudo rm -f /etc/alternatives/unpack200
sudo ln -sf /opt/java/jdk1.8.0_131/jre/bin/unpack200 /etc/alternatives/unpack200
sudo rm -f /etc/alternatives/unpack200.1*
sudo ln -sf /opt/java/jdk1.8.0_131/jre/man/man1/unpack200.1 /etc/alternatives/unpack200.1



