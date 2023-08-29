#!/usr/bin/env bash

set -e

# Clean out folder
find /opt/out/ -mindepth 1 -maxdepth 1 -exec rm -r -- {} +

cd /opt
mkdir -p src

rsync -azh /opt/orig/april-asr/ /opt/src/april-asr/
rsync -azh /opt/orig/obs-catpion/ /opt/src/obs-catpion/

pushd patches
for d in */ ; do
    if [ -d "${d}" ] ; then
        for p in ${d}*.patch; do
            if [ -f "/opt/patches/$p" ] ; then
                echo "patch /opt/patches/$p"
                git -C /opt/src/${d} apply /opt/patches/$p
            fi
        done
    fi
done
popd

export ONNX_ROOT=/opt/orig/onnxruntime/
export ONNXRuntime_INCLUDE_DIR=/opt/orig/onnxruntime/include/
export ONNXRuntime_ROOT_DIR=/opt/orig/onnxruntime/
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/orig/onnxruntime/lib/

cd /opt/src/april-asr/

mkdir build

/usr/bin/cmake -S . -B build \
    -DBUILD_SHARED_LIBS:BOOL=ON \
    -DCMAKE_INSTALL_LIBDIR:PATH=/usr/lib64 \
    -DCMAKE_INSTALL_PREFIX:PATH=/usr \
    -DCMAKE_VERBOSE_MAKEFILE:BOOL=OFF

/usr/bin/cmake --build "build"
/usr/bin/cmake --install "build"

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
rsync -azh /opt/src/april-asr/build/ /opt/out/april-asr/
