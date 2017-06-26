#!/bin/bash


function useage {
  printf "$1\n\n" 
  printf "fixed-linux-ip.sh <10.36.68.xx>\n\n"
  printf "xx must be between 20 and 254\n"
  exit 1
}


if [ -z $1 ] ; then
  useage "You must provide an address number"
fi


if [[ $1 == ?(-)+([0-9]) ]]  ; then
  lastOctet=$1
else
  usage "You did not provide a number "
fi


tmpfile=$(mktemp "/tmp/set-fixed-ip-XXXXXX.sh")
cp set-fixed-ip.sh ${tmpfile}



