#!/usr/bin/env bash

set -x
set -e

cp build_out/obs-catpion/obs-catpion.so                             /usr/lib64/obs-plugins/

cp build_out/april-asr/libaprilasr.so                               /usr/lib64/
cp build_out/april-asr/libaprilasr.so.2023                          /usr/lib64/
cp build_out/april-asr/libaprilasr.so.2023.5.12                     /usr/lib64/

cp cache/onnxruntime-linux-x64-1.15.1/lib/libonnxruntime.so         /usr/lib64/
cp cache/onnxruntime-linux-x64-1.15.1/lib/libonnxruntime.so.1.15.1  /usr/lib64/

mkdir /usr/share/obs/obs-plugins/obs-catpion

cp -r src/obs-catpion/data/* /usr/share/obs/obs-plugins/obs-catpion/