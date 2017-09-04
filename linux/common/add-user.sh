#!/bin/bash

if [ "${1}" = "" ] ; then
  echo "You must specify both user name and pw"
  echo "${0} <user> <passwd>"
  exit 1
fi

if [ "${2}" = "" ]; then
  echo "You must specify both user name and pw"
  echo "${0} ${1} <passwd>"
  exit 1
fi

user=${1}
pw=${2}
sudoersFile='sudoers'
if [ $(grep -c "^${user}:"  /etc/passwd ) -eq  "0" ] ; then
  adduser ${user} --gecos "${user} Lab User" --disabled-password
  usermod -a -G sudo ${user}
else
  echo "user ${user} already exists !"
fi

echo ${user}:${pw} | chpasswd
mkdir -p /home/${user}/workspace
mkdir -p /home/${user}/bin

# set Java home
varsFile=".bashrc"
echo "export JAVA_HOME=/opt/jdk1.8" > "/tmp/${varsFile}"
echo "export HISTSIZE=10000" >> "/tmp/${varsFile}"
echo "export PATH=/opt/jdk1.8/bin:/home/${user}/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin">> "/tmp/${varsFile}"
if [ -d "/home/${user}/${varsFile}" ] ; then
  cat "/home/${user}/${varsFile}" | grep -v 'export JAVA_HOME=' |
    grep -v "export HISTSIZE" |
    grep -v "PATH=">> "/tmp/${varsFile}"
fi

mv -f "/tmp/${varsFile}" "/home/${user}/${varsFile}"

mkdir -p /home/${user}/workspace
cd /home/${user}/workspacegit clone https://github.com/xjschwen/TrobotWorkstationSetup.git
ln -s /home/{$user}/workspace/TrobotWorkstationSetup/eclipse.sh /home/{$user}/eclipse.sh
chown -R ${user}:${user} /home/${user}/
