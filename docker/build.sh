#!/bin/bash

BUILD_DIR=$(dirname $(readlink -f $0))/src
IMAGE_NAME="ros1:noetic"
USER_NAME="ros1"

docker build \
    -t ${IMAGE_NAME} \
    --build-arg UID=$(id -u) \
    --build-arg USER_NAME=${USER_NAME} \
    --build-arg HOSTNAME=$(hostname) \
    ${BUILD_DIR}