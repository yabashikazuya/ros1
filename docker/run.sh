#!/bin/bash

USER_ID=$(id -u)
XSOCK="/tmp/.X11-unix"
XAUTH="/tmp/.docker.xauth"

HOST_WS=$(dirname $(dirname $(readlink -f $0)))/shared_dir
CATKIN_WS=$(dirname $(dirname $(readlink -f $0)))/catkin_ws

DOCKER_VOLUME="-v ${XSOCK}:${XSOCK}:rw"
DOCKER_VOLUME="${DOCKER_VOLUME} -v ${XAUTH}:${XAUTH}:rw"
DOCKER_VOLUME="${DOCKER_VOLUME} -v ${HOST_WS}:/home/ros1/shared_dir:rw"
DOCKER_VOLUME="${DOCKER_VOLUME} -v ${CATKIN_WS}:/home/ros1/catkin_ws:rw"

DOCKER_ENV="-e XAUTHORITY=${XAUTH}"
DOCKER_ENV="${DOCKER_ENV} -e DISPLAY=$DISPLAY"
DOCKER_ENV="${DOCKER_ENV} -e QT_X11_NO_MITSHM=1"
DOCKER_ENV="${DOCKER_ENV} -e USER_ID=${USER_ID}"
DOCKER_ENV="${DOCKER_ENV} -e HOME=/home/ros1"
IMAGE_NAME="ros1:noetic"

DOCKER_IMAGE="${IMAGE_NAME}"

docker run \
  --rm -it \
  --name ros1 \
  --net "host" \
  --user ros1 \
  ${DOCKER_ENV} \
  ${DOCKER_VOLUME} \
  ${DOCKER_IMAGE} 