#!/bin/bash
#
# Tries to clone and install the latest CMake for you
# Will try to install to INSTALL_PREFIX

INSTALL_PREFIX=/usr/local

if [ ! -d ../CMake ]; then
    echo Cloning CMake
    git clone --depth 1 https://github.com/kitware/cmake ../CMake
    cd ../CMake
else
    echo Pulling CMake updates
    cd ../CMake
    git pull
fi

./configure --prefix=${INSTALL_PREFIX}
echo Building CMake
make -j4
echo Done. Installing to ${INSTLAL_PREFIX}
sudo make install
