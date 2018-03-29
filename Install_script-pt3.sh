#! /bin/bash
# This script should install and build all needed stuff for
# using the SDRPlay on Ubuntu 16.04 or later.  It must be
# run as root.  
# 
# This is part Three.
# Here we build GNURadio

sudo apt-get install libusb-1.0-0-dev libasound2-dev -y

sudo apt-get install python-cheetah libboost-dev libboost-all-dev swig2.0 python-pkgconfig liborc-0.4-dev libfftw3-dev libasound2-dev libzmq-dev libgsl0-dev python-sphinx libcppunit-dev libgsm1-dev libgsl0-dev python-mako -y

sudo apt-get install doxygen python-qt4 libqt4-dev python-qwt5-qt4 -y

sudo apt-get install python-wxgtk3.0 -y

sudo apt-get install libxml2-dev libzmq3-dev python-gtk2-dev libxml++2.6-dev python-lxml libwxgtk3.0-dev python-qwt5-qt4 pyqt4-dev-tools python3-pyqt4 python-gtk2 -y

sudo apt-get install gnuradio -y

git clone https://github.com/willcode/gr-osmosdr
cd gr-osmosdr
git checkout sdrplay2
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=~/gr-osmosdr -DENABLE_NONFREE=yes ..
make
mkdir ~/gr-osmosdr
make install