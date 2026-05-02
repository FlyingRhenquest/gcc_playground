# gcc playground

I'm setting this project up to build the gcc master branch
from their github mirror if you want to play with it now but
your distribution doesn't have packages for it yet.

# Scripts

## build_gcc.sh

This clones down gcc and builds it. It installs the 
compiler to /usr/local/gcc, which should not conflict 
with other compilers that you have on the system.
Please review the script and toolchain files prior
to running them to make sure what's going on in
there meets your needs.

This project will install the toolchain.cmake file in
/usr/local/gcc as well, so you can call CMake with
-DCMAKE\_TOOLCHAIN\_FILE=/usr/local/gcc/toolchain.cmake
to build with the gcc compiler this project installs.
That should keep it reasonably well isolated from
anything else it could interfere with on your system

I'm doing a shallow clone of the gcc master branch
and configuring the gcc build to assume that you
already have some other compiler on the system.
So it won't try to build the bootstrap stuff that
can add a lot of time to the build. I think these
assumptions are probably pretty reasonable if you're
interested in playing with the latest gcc. You can
edit the build\_gcc.sh script if that doesn't meet
your needs.

Set up this way, it should download a couple hundred
megabytes of code that it needs to build and the
build will probably take 20-30 minutes.

The toolchain file enables reflection and experimental
import std support. If you change the install directory,
be sure to modify the toolchain file to point to the
correct location for the compiler. I'd suggest building
the latest CMake as well (I include a script for that,
too.) Depending on the version, you may need a different
uuid for to enable the import std functionality. If
you're way in the future, it might not even be experimental
anymore.

These scripts try to do the right thing to make this
whole process as painless as I can make it. Please
let me know if you have any trouble with them.

## build_cmake.sh

This clones down the CMake main branch and builds
it. It installs CMake to /usr/local. If you
build your own CMake, you should probably uninstall
any stock OS ones you may have installed or make
sure you have /usr/local/bin first in your path.
Unless you like typing /usr/local/bin/cmake a lot.
I don't judge.

This is a fairly simple build compared to the gcc
one.

# Testing

If you want to do a quick test with a library that
does reflection, feel free to grab [autocereal](https://github.com/FlyingRhenquest/autocereal)
and run the unit tests for it. It requires [Cereal](https://github.com/USCilab/cereal)
to be installed separately, if you're running
a fairly standard library you can just use the one
from your package manager. It also expects gtest
to be installed, that's libgtest-dev on Debian
if you don't already have it installed.

If you have Cereal and gtest, you should just be 
able to do:

    git clone https://github.com/FlyingRhenquest/autocereal.git
    mkdir autocereal/build
    cd autocereal/build
    cmake .. -DCMAKE_TOOLCHAIN_FILE=/usr/local/gcc/toolchain.cmake -DAUTOCEREAL_BUILD_TESTS=ON
    make
    test/test

If you get a bunch of OKs, you're good to go!
