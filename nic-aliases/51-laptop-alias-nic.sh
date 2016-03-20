# This script will alias the eth0 on the Jeff's Laptop s so they can 
# run on the robot aswell as in the lab and Schwennesen Home without
# causing a ton of extra work

# this script was running so fast that DHCP was not complete with resolving
# before ifconfig was run, therefore the MOTD was not being updated correctly
# 
sleept 10

ifconfig eth0:0 10.36.68.51 netmask 255.255.255.0 broadcast 10.36.68.255

printf "This laptop to FRC 3668 and FTC 8492 !!\n\n" > /etc/motd
printf "It responds to 2 IP addresses\n\n" >> /etc/motd
ifconfig | grep inet | grep -v 127.0.0.1 | grep -v inet6 | sort -r >> /etc/motd
printf "\n\nGo FRC Team 3668 Trobots !!\n\n" >> /etc/motd
printf "\n\nGo FRC Team 8492 Titainum Trojans !!\n\n" >> /etc/motd
exit 0

