#! /bin/bash
# overclock to make system faster, cooling necessary!!
sudo wget -O /usr/bin/zram.sh https://raw.githubusercontent.com/novaspirit/rpi_zram/master/\zram.sh
# First we install needed dependancies.
#######
apt install -y build-essential automake cmake g++ swig libgtk2.0-dev libpulse-dev libpython-dev python-numpy mesa-utils libegl1-mesa libglw1-mesa-dev freeglut3-dev freeglut3

apt install -y libusb-1.0-0-dev libasound2-dev python-cheetah swig2.0 python-pkgconfig liborc-0.4-dev libfftw3-dev libzmq-dev libgsl0-dev 
apt install -y python-sphinx libcppunit-dev libgsm1-dev python-mako
apt install -y doxygen python-qt4 libqt4-dev python-qwt5-qt4 python-wxgtk3.0 libboost-dev libboost-all-dev
apt install -y libxml2-dev libzmq3-dev python-gtk2-dev libxml++2.6-dev python-lxml libwxgtk3.0-dev pyqt4-dev-tools python3-pyqt4 python-qt4 python-gtk2
# download all files from git
git clone https://github.com/jgaeddert/liquid-dsp
wget https://github.com/wxWidgets/wxWidgets/releases/download/v3.1.0/wxWidgets-3.1.0.tar.bz2
tar -xvjf wxWidgets-3.1.0.tar.bz2  
git clone https://github.com/pothosware/SoapySDR.git
git clone https://github.com/pothosware/SoapySDRPlay.git
git clone https://github.com/pothosware/SoapyRemote.git
git clone https://github.com/cjcliffe/CubicSDR.git
git clone https://github.com/gnuradio/gnuradio.git

cd Desktop
mkdir sdrplay
cd sdrplay
git clone https://github.com/willcode/gr-osmosdr
cd ../..

# Build liquid-dsp
cd liquid-dsp
./bootstrap.sh
./configure --enable-fftoverride 
make 
make install
ldconfig
cd ..

# Build wxwidgets
cd wxWidgets-3.1.0/
mkdir -p ~/Develop/wxWidgets-staticlib
./autogen.sh 
./configure --with-opengl --disable-shared --enable-monolithic --with-libjpeg --with-libtiff --with-libpng --with-zlib --disable-sdltest --enable-unicode --enable-display --enable-propgrid --disable-webkit --disable-webview --disable-webviewwebkit --prefix=`echo ~/Develop/wxWidgets-staticlib` CXXFLAGS="-std=c++0x" --with-libiconv=/usr
make
make install
cd ..

# Build SoapySDR
cd SoapySDR
mkdir build
cd build
cmake ..
make -j4
make install
ldconfig
cd ../..

# Build Soapy SDRPlay module
cd SoapySDRPlay
mkdir build
cd build
cmake ..
make
make install
cd ../..

# Build SoapyRemote
cd SoapyRemote
mkdir build
cd build
cmake ..
make
make install
cd ../..

# Build Cubic
cd CubicSDR
mkdir build
cd build
cmake ../ -DCMAKE_BUILD_TYPE=Release -DwxWidgets_CONFIG_EXECUTABLE=~/Develop/wxWidgets-staticlib/bin/wx-config
make
make install
cd ../..
rm -R ~/Develop
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


