#! /bin/bash
# First we install needed dependancies.
# sudo wget -O /usr/bin/zram.sh https://raw.githubusercontent.com/novaspirit/rpi_zram/master/\zram.sh 
#######
apt update
apt upgrade
# download all files from git
git clone https://github.com/gnuradio/gnuradio.git

cd Desktop
mkdir sdrplay
cd sdrplay
git clone https://github.com/willcode/gr-osmosdr
cd ../..

##########################
# change architecture of the gcc compiler
cp /etc/apt/sources.list /etc/apt/sources.bak.list
echo "deb http://merlin.fit.vutbr.cz/debian/ jessie main contrib non-free
deb-src http://merlin.fit.vutbr.cz/debian/ jessie main

deb http://security.debian.org/ jessie/updates main

deb http://merlin.fit.vutbr.cz/debian/ jessie-updates main" > /etc/apt/sources.list
apt update
apt install --only-upgrade gcc-4.9
rm /etc/apt/sources.list
cp /etc/apt/sources.bak.list /etc/apt/sources.list
apt update
#
# build VOLK
git submodule init
git submodule update
cd volk
mkdir build
cd build
cmake ..
make
sudo make install
cd ../..

# build gnuradio
mkdir build
cd build
cmake -DENABLE_DOXYGEN=OFF ..
make
sudo make install
cd ../..

# build gr-osmosdr
cd gr-osmosdr
git checkout sdrplay2
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=~/gr-osmosdr -DENABLE_NONFREE=yes ..
make
mkdir ~/gr-osmosdr
make install

# set ENV variables
echo "export LD_LIBRARY_PATH=/home/pi/gr-osmosdr/lib:" >> .bashrc
echo "export PYTHONPATH=/home/pi/gr-osdmosdr/lib/python2.7/dist-packages:" >> .bashrc
reboot


