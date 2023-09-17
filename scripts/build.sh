#!/usr/bin/env bash

set -e

# Clean out folder
find /opt/out/ -mindepth 1 -maxdepth 1 -exec rm -r -- {} +

cd /opt
mkdir -p src

rsync -azh /opt/orig/obs-catpion/ /opt/src/obs-catpion/

# BUILD
cd /opt/src/obs-catpion/
mkdir build

cmake -S . -B build \
    -DBUILD_SHARED_LIBS:BOOL=ON \
    -DCMAKE_INSTALL_LIBDIR:PATH=/usr/lib64 \
    -DCMAKE_INSTALL_PREFIX:PATH=/usr \
    -DCMAKE_VERBOSE_MAKEFILE:BOOL=OFF

/usr/bin/cmake --build "build"
/usr/bin/cmake --install "build"

rsync -azh /opt/src/obs-catpion/build/ /opt/out/obs-catpion/
