#! /bin/bash
# This script should update the architecture of raspberry pi compiler
# Raspbian comes with armv6 only, newer raspberry pi's

# before running this script edit /etc/apt/sources.list to:
#deb http://merlin.fit.vutbr.cz/debian/ jessie main contrib non-free
#deb-src http://merlin.fit.vutbr.cz/debian/ jessie main

#deb http://security.debian.org/ jessie/updates main

#deb http://merlin.fit.vutbr.cz/debian/ jessie-updates main

apt-get update
apt-get install debian-archive-keyring
apt-get update
apt-get dist-upgrade
apt-get install gcc-4.9 gcc-4.9-base libgcc-4.9-dev libgcc1 gcc
dpkg -l | grep gcc