#! /bin/bash
# First we install needed dependancies.
#######
apt-get install git build-essential cmake libusb-1.0-0-dev
apt-get install libasound2-dev
apt-get install python-cheetah libboost-all-dev swig2.0 python-pkgconfig liborc-0.4-dev libfftw3-dev libasound2-dev libzmq-dev libgsl0-dev python-sphinx libcppunit-dev libgsm1-dev python-numpy libgsl0-dev python-mako
apt-get install doxygen
apt-get install python-qt4 libqt4-dev python-qwt5-qt4
apt-get install python-wxgtk3.0
apt-get update
apt-get upgrade
apt-get install gnuradio gnuradio-dev

gnuradio-companion --version
sleep 30

cd Desktop
mkdir sdrplay
cd sdrplay
git clone https://github.com/willcode/gr-osmosdr
cd gr-osmosdr/
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFX=~/gr-osmosdr -DENABLE_NONFREE=yes ..
make
mkdir ~/gr-osmosdr
make install
ldconfig

cd ../../..



