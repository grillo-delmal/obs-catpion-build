#!/usr/bin/env bash

set -e

podman build -t obs-catpion-build .

mkdir -p $(pwd)/build_out

podman unshare chown $UID:$UID -R $(pwd)/build_out

podman run -ti --rm \
    -v $(pwd)/build_out:/opt/out/:Z \
    -v $(pwd)/src/obs-catpion:/opt/orig/obs-catpion/:ro,Z \
    localhost/obs-catpion-build:latest

podman unshare chown 0:0 -R $(pwd)/build_out
