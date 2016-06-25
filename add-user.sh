#!/bin/bash
user=trobot

if $(grep -c /etc/passwd "^${user}:" ) -eq  "0"; then

  mkdir -p /home/${user}/
  adduser ${user} --gecos "Trobot Lab User"

else
  echo "user ${user} already exists !"
fi

#Add more like desktop shortcuts etc
#add more to set JAVA_HOME
#add to the path for running eclipseInstaller
