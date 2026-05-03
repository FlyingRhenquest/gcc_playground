# This is a cmake toolchain to build with the experimental reflection support in
# gcc-16.

# To build with this toolchain file, call "cmake -DCMAKE_TOOLCHAIN_FILE=/path/to/this/file " ...
set(CMAKE_C_COMPILER /usr/local/gcc/bin/gcc)
set(CMAKE_CXX_COMPILER /usr/local/gcc/bin/g++)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD 26)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_FLAGS_INIT "-freflection")
# This is needed by cmake and can change depending on what version of cmake
# you're using. It'll tell you where to look up the correct value if this
# one isn't correct for your cmake (generally some experimental.rst file somewhere.)
set(CMAKE_EXPERIMENTAL_CXX_IMPORT_STD "d0edc3af-4c50-42ea-a356-e2862fe7a444")
set(CMAKE_CXX_STD_MODULES_JSON "/usr/local/gcc/lib64/libstdc++.modules.json")
