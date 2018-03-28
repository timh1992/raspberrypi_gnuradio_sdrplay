#! /bin/bash
# This script should install and build all needed stuff for
# using the SDRPlay on Ubuntu 16.04 or later.  It must be
# run as root.  
# 
# This is part Three.
# Here we build GNURadio

apt-get update
apt-get install debian-archive-keyring
apt-get update
apt-get dist-upgrade
apt-get install gcc-4.9 gcc-4.9-base libgcc-4.9-dev libgcc1 gcc
dpkg -l | grep gcc


git clone https://git.gnuradio.org/git/gnuradio.git
cd gnuradio/
git submodule init
git submodule update
# First building the volk-module
cd volk
mkdir build
cd build
cmake ..
make
make install
cd ../..
# building the GNUradio software
mkdir build
cd build
cmake -DENABLE_DOXYGEN=OFF ..
make
sudo make install
cd ../..

# build grosmocom
git clone https://github.com/willcode/gr-osmosdr
cd gr-osmosdr
git checkout sdrplay2
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=~/gr-osmosdr -DENABLE_NONFREE=yes ..
make
mkdir ~/gr-osmosdr
make install

echo "."
echo "Installation is finished."