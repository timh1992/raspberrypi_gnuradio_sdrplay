#! /bin/bash
# This script should install and build all needed stuff for
# using the SDRPlay on Ubuntu 16.04 or later.  It must be
# run as root.  
# 
# First we install needed dependancies.

apt-get install git build-essential automake cmake g++ swig
apt-get install libgtk2.0-dev libpulse-dev libpython-dev python-numpy
apt-get install mesa-utils libeglw1-mesa libglw1-mesa-dev
apt-get install freeglut3-dev freeglut3

apt-get install libusb-1.0-0-dev
apt-get install python-cheetah libboost-all-dev swig2.0 python-pkgconfig liborc-0.4-dev libfftw3-dev libasound2-dev libzmq-dev libgsl0-dev python-sphinx libcppunit-dev libgsm1-dev python-numpy libgsl0-dev python-mako
apt-get install doxygen
apt-get install python-qt4 libqt4-dev python-qwt5-qt4
apt-get install python-wxgtk3.0
apt-get install libboost-dev
apt-get install libxml2-dev libzmq3-dev python-gtk2-dev libxml++2.6-dev python-lxml libwxgtk3.0-dev pyqt4-dev-tools python3-pyqt4 python-gtk2

# Now we'll git the projects we need

git clone https://github.com/jgaeddert/liquid-dsp
wget https://github.com/wxWidgets/wxWidgets/releases/download/v3.1.0/wxWidgets-3.1.0.tar.bz2
tar -xvjf wxWidgets-3.1.0.tar.bz2  
git clone https://github.com/pothosware/SoapySDR.git
git clone https://github.com/pothosware/SoapySDRPlay.git
git clone https://github.com/pothosware/SoapyRemote.git
git clone https://github.com/cjcliffe/CubicSDR.git

# Build liquid-dsp

cd liquid-dsp
./bootstrap.sh
./configure --enable-fftoverride 
make -j4
make install
ldconfig
cd ..

# Build wxwidgets

cd wxWidgets-3.1.0/
mkdir -p ~/Develop/wxWidgets-staticlib
./autogen.sh 
./configure --with-opengl --disable-shared --enable-monolithic --with-libjpeg --with-libtiff --with-libpng --with-zlib --disable-sdltest --enable-unicode --enable-display --enable-propgrid --disable-webkit --disable-webview --disable-webviewwebkit --prefix=`echo ~/Develop/wxWidgets-staticlib` CXXFLAGS="-std=c++0x" --with-libiconv=/usr
make -j4 
make install
cd ..

echo "."
echo "First part of installation done.   Now run the SDRPlay driver file you"
echo "downloaded from their site.  Be sure to use sudo to run it!"


