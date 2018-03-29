#! /bin/bash
# This script should install and build all needed stuff for
# using the SDRPlay on Ubuntu 16.04 or later.  It must be
# run as root.  
# 
# This is part Three.
# Here we build GNURadio

sudo apt-get install git build-essential cmake libusb-1.0-0-dev
sudo apt-get install libasound2-dev

### gnuradio
sudo apt-get install python-cheetah libboost-all-dev swig2.0 python-pkgconfig liborc-0.4-dev libfftw3-dev libasound2-dev libzmq-dev libgsl0-dev python-sphinx libcppunit-dev libgsm1-dev python-numpy libgsl0-dev python-mako

sudo apt-get install doxygen

sudo apt-get install python-qt4 libqt4-dev python-qwt5-qt4

sudo apt-get install python-wxgtk3.0

sudo apt-get install python-cheetah libboost-dev libboost-all-dev libfftw3-dev swig
sudo apt-get install libxml2-dev libzmq3-dev python-gtk2-dev python-numpy libxml++2.6-dev python-lxml libwxgtk3.0-dev python-qwt5-qt4 pyqt4-dev-tools python3-pyqt4 python-gtk2

git clone http://git.gnuradio.org/git/gnuradio.git #www.github.com/gnuradio/gnuradio
cd gnuradio/

git submodule init
git submodule update
cd volk
mkdir build
cd build
cmake ..
make
sudo make install
cd ../..

mkdir build
cd build
cmake -DENABLE_DOXYGEN=OFF ..
make
sudo make install
cd ../..


git clone https://github.com/willcode/gr-osmosdr
cd gr-osmosdr
git checkout sdrplay2
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=~/gr-osmosdr -DENABLE_NONFREE=yes ..
make
mkdir ~/gr-osmosdr
make install