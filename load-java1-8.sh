#!/bin/bash
err_report() {
    echo "Error on line $1"
}

trap 'err_report $LINENO' ERR

curdir=$(readlink -m $HOME)
javaInstaller="jdk-8u131-linux-x64.tar.gz"
jdk_tar=$(find /media/ -name ${javaInstaller} | sort | tail -1)
jdkName="jdk1.8.0_131"
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
sudo ln -fs $(readlink -f "$jdkName") "jdk1.8"

popd

