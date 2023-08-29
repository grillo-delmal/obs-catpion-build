#!/usr/bin/env bash

set -e

if [ ! -f "./cache/onnxruntime-linux-x64-1.15.1/lib/libonnxruntime.so" ]; then
    mkdir -p $(pwd)/cache
    pushd cache
    wget https://github.com/microsoft/onnxruntime/releases/download/v1.15.1/onnxruntime-linux-x64-1.15.1.tgz
    tar xzvf onnxruntime-linux-x64-1.15.1.tgz
    popd
fi

pushd src
pushd obs-catpion
sh prepare.sh
popd
popd

podman build -t obs-catpion-build .

mkdir -p $(pwd)/build_out

podman unshare chown $UID:$UID -R $(pwd)/build_out

podman run -ti --rm \
    -v $(pwd)/.git:/opt/.git/:ro,Z \
    -v $(pwd)/build_out:/opt/out/:Z \
    -v $(pwd)/patches:/opt/patches/:ro,Z \
    -v $(pwd)/src/april-asr:/opt/orig/april-asr/:ro,Z \
    -v $(pwd)/src/obs-catpion:/opt/orig/obs-catpion/:ro,Z \
    -v $(pwd)/cache/onnxruntime-linux-x64-1.15.1:/opt/orig/onnxruntime/:ro,Z \
    localhost/obs-catpion-build:latest

podman unshare chown 0:0 -R $(pwd)/build_out
