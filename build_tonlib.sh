#!/bin/bash
set -e

echo "Building image"
docker build -t tonlib-builder -f infrastructure/tonlib.Dockerfile . $@

echo "Running container"
CONTAINER_ID=$(docker run -d tonlib-builder)

echo "Copying libtonlibjson.so"
docker cp ${CONTAINER_ID}:/ton/build/tonlib/libtonlibjson.so.0.5 ton/distlib/linux/libtonlibjson.so

echo "Removing container"
docker container rm ${CONTAINER_ID}
