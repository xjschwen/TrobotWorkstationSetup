#!/bin/bash
err_report() {
    echo "Error on line $1"
    exit 1
}

trap 'err_report $LINENO' ERR


download_dir="/home/jas/Downloads"
target_file="${download_dir}/2017-11-29-raspbian-stretch-lite.zip"
url="http://director.downloads.raspberrypi.org/raspbian_lite/images/raspbian_lite-2017-12-01/2017-11-29-raspbian-stretch-lite.zip"

mkdir -p ${download_dir}

echo $target_file

if [ ! -f "${target_file}" ] ; then
   wget -O${target_file} ${url}
fi

ls -l ${target_file}
