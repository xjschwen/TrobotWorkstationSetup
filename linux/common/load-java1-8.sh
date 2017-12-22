#!/bin/bash
err_report() {
    echo "Error on line $1"
    exit 1
}

trap 'err_report $LINENO' ERR

curdir=$(readlink -m $HOME)

# if pi use pi name
if [ "$(cat /proc/cpuinfo | grep "ARMv7")"  > "0" ] ; then
	javaInstaller="jdk-8u151-linux-arm64-vfp-hflt.tar.gz"
else
	javaInstaller="jdk-8u151-linux-x64.tar.gz"
fi

jdk_tar=~/$javaInstaller

if [ -z ${jdk_tar} ] ; then
	jdk_tar=$(find /media/ -name ${javaInstaller} | sort | tail -1)
fi

if [ -z ${jdk_tar} ] ; then
	echo "ERROR: Could not locate the correct installer"
	echo "Looking for ${javaInstaller}"
	exit 1
fi 

jdkName="jdk1.8.0_151"
downloadDir="$curdir/Downloads"
installroot="/opt/java"
echo ${jdk_tar}


cp ${jdk_tar} ${downloadDir}

sudo mkdir -p "$installroot"
pwd
pushd $installroot
sudo tar -zxvf "${downloadDir}/${javaInstaller}"  -C "${installroot}"
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

 



