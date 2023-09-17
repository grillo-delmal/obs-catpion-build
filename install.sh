#!/usr/bin/env bash

set -x
set -e

cp build_out/obs-catpion/obs-catpion.so /usr/lib64/obs-plugins/
mkdir /usr/share/obs/obs-plugins/obs-catpion
cp -r src/obs-catpion/data/* /usr/share/obs/obs-plugins/obs-catpion/