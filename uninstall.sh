#!/usr/bin/env bash

set -x
set -e

rm /usr/lib64/obs-plugins/obs-catpion.so

rm /usr/lib64/libaprilasr.so 
rm /usr/lib64/libaprilasr.so.2023 
rm /usr/lib64/libaprilasr.so.2023.5.12 

rm /usr/lib64/libonnxruntime.so 
rm /usr/lib64/libonnxruntime.so.1.15.1 

rm -r /usr/share/obs/obs-plugins/obs-catpion
