#!/bin/bash
err_report() {
    echo "Error on line $1"
    exit 1
}

trap 'err_report $LINENO' ERR

base_url="http://downloads.raspberrypi.org/raspbian_lite/images/raspbian_lite-2017-07-05"
download_dir="/home/jas/Downloads"

mkdir -p ${download_dir}

sha256_file="2017-07-05-raspbian-jessie-lite.zip.sha256	"

if [ ! -f "${download_dir}/${sha256_file}" ] ; then
  echo "pulling down ${base_url}/${sha256_file}"
   wget -O${download_dir}/${sha256_file} ${base_url}/${sha256_file}
fi

target_file="2017-07-05-raspbian-jessie-lite.zip"
if [ ! -f "${download_dir}/${target_file}" ] ; then
   echo "pulling down ${base_url}/${target_file}"
   wget -O${download_dir}/${target_file} ${base_url}/${target_file}
fi

pushd ${download_dir}
printf "\n\n"
sha256sum -c ${sha256_file}
ls -l ${sha256_file}
ls -l ${target_file}
printf "\n\n"
popd
