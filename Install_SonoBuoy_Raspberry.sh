#! /bin/bash
# First we install needed dependancies.
#######
sudo apt install -y build-essential automake cmake g++ swig libgtk2.0-dev libpulse-dev libpython-dev python-numpy mesa-utils libeglw1-mesa libglw1-mesa-dev freeglut3-dev freeglut3

# download all files from git
git clone https://github.com/jgaeddert/liquid-dsp
wget https://github.com/wxWidgets/wxWidgets/releases/download/v3.1.0/wxWidgets-3.1.0.tar.bz2
tar -xvjf wxWidgets-3.1.0.tar.bz2  
git clone https://github.com/pothosware/SoapySDR.git
git clone https://github.com/pothosware/SoapySDRPlay.git
git clone https://github.com/pothosware/SoapyRemote.git
git clone https://github.com/cjcliffe/CubicSDR.git
git clone https://github.com/gnuradio/gnuradio.git

#

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

# Build SoapySDR
cd SoapySDR
mkdir build
cd build
cmake ..
make -j4
make install
ldconfig
cd ..
cd ..

# Build Soapy SDRPlay module
cd SoapySDRPlay
mkdir build
cd build
cmake ..
make
make install
cd ..
cd ..

# Build SoapyRemote
cd SoapyRemote
mkdir build
cd build
cmake ..
make
make install
cd ..
cd ..

# Build Cubic
cd CubicSDR
mkdir build
cd build
cmake ../ -DCMAKE_BUILD_TYPE=Release -DwxWidgets_CONFIG_EXECUTABLE=~/Develop/wxWidgets-staticlib/bin/wx-config
make
make install
cd ..
cd ..
rm -R ~/Develop
##########################



