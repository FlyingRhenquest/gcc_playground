#!/bin/bash
#
# Clones and builds the current gcc master branch.
# By default this builds to /usr/local/gcc so that
# the compiler does not interfere with any installed
# system ones. A CMake toolchain file to use it will
# also be installed in that directory.
#
# gcc will be cloned to ../gcc and built in
# ../gcc/build. If gcc already exists there
# we'll do a git pull instead and try to
# rebuild it with what's there.
#
# The toolchain enables reflection and the experimental
# import std support by default.
#
# I'm doing a shallow clone of gcc, but you can still
# expect it to be a couple hundred megabytes of stuff
# to bring down.

INSTALL_DIR=/usr/local/gcc
PLAYGROUND_DIR=$(pwd)

function run_configure() {
   ../configure --prefix=${INSTALL_DIR} --enable-languages=c,c++ --disable-multilib --with-local-prefix=${INSTALL_DIR} --with-arch=native --with-tune=native --disable-bootstrap
}

if [ ! -d ../gcc ]; then
    echo Cloning GCC and prerequisite libraries
    git clone --depth 1 --recurse-submodules https://github.com/gcc-mirror/gcc.git ../gcc 
    mkdir -p ../gcc/build
    cd ../gcc
    # Download prerequisite libraries gmp, mpfr and mpc
    ./contrib/download_prerequisites
    cd build
    run_configure
else
    echo Pulling gcc updates from github
    PROBABLY_NEED_CONFIGURE=0
    if [ ! -d ../gcc/build ]; then
        mkdir -p ../gcc/build
        PROBABLY_NEED_CONFIGURE=1
    fi
    cd ../gcc
    git pull
    echo Downlading preqrequisites if necessary
    # Download prerequisite libraries gmp, mpfr and mpc
    ./contrib/download_prerequisites
    cd build
    if (( PROBABLY_NEED_CONFIGURE )); then
        run_configure
    fi
fi

make -j4
echo Build complete. Running install
sudo make install
echo copying toolchain to ${INSTALL_DIR}
sudo cp ${PLAYGROUND_DIR}/toolchain.cmake ${INSTALL_DIR}

echo Install complete. To use, call CMake with
echo CMake -DCMAKE_TOOLCHAIN_FILE=${INSTALL_DIR}/toolchain.cmake ...

