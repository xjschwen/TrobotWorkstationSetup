#!/bin/bash
err_report() {
    echo "Error on line $1"
    exit 1
}

trap 'err_report $LINENO' ERR

curdir=$(readlink -m $HOME)

# if pi use pi name
if [ "$(cat /proc/cpuinfo | grep "ARMv7")"  > "0" ] ; then
  #dispite the fact that Pi3 are 64 bit hw the os is 32 bit
  #Pi2 is 32 bit and pi3 is 64 bit
  javaInstaller="jdk-8u151-linux-arm32-vfp-hflt.tar.gz"

else
	javaInstaller="jdk-8u151-linux-x64.tar.gz"
fi

if [ -z ${jdk_tar} ] ; then
  echo "Searching /media for -name ${javaInstaller}"
	jdk_tar=$(find /media/ -name ${javaInstaller} | sort | tail -1)
fi

if [ -z ${jdk_tar} ] ; then
  echo "Searching ~/ for -name ${javaInstaller}"
	jdk_tar=$(find ~/ -name ${javaInstaller} | sort | tail -1)
fi

if [ -z ${jdk_tar} ] ; then
	echo "ERROR: Could not locate the correct installer"
	echo "Looking for ${javaInstaller}"
	exit 1
fi

jdkName="jdk1.8.0_151"
downloadDir=$(readlink -f "~/Downloads")
mkdir -p ${downloadDir}

installroot="/opt/java"
echo ${jdk_tar}

if [ ! -f ${downloadDir}/${javaInstaller} ] ; then
  cp ${jdk_tar} ${downloadDir}
fi

sudo mkdir -p "$installroot"
pwd
pushd $installroot

sudo tar -zxvf ${downloadDir}/${javaInstaller}  -C "${installroot}"
sudo chown root:root "$installroot/$jdkName"
sudo rm -Rf $installroot/jdk1.8
sudo ln -fs "$jdkName" "jdk1.8"

popd

sudo cp environment /etc/environment

cat ~/.bashrc |  sed 's#export\sJAVA_HOME\s*=.*#export JAVA_HOME=/opt/java/jdk1.8#g' > ~/.bashrc_new
rm  -f ~/bashrc
mv ~/.bashrc_new ~/.bashrc

export JAVA_HOME=/opt/java/jdk1.8
cat ~/.bashrc |  sed 's#export\sPATH\s*=.*##g' > ~/.bashrc_new
echo "export PATH=${JAVA_HOME}:${JAVA_HOME}/bin:${PATH}" >> ~/.bashrc_new
rm  -f ~/bashrc
mv ~/.bashrc_new ~/.bashrc
