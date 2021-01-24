#!/usr/bin/env bash

IMAGE_NAME=easy_ai
CONTAINER_NAME=${IMAGE_NAME}_$USER

xhost +local:root 1>/dev/null 2>&1
docker exec \
    -u "$USER" \
    -it "${CONTAINER_NAME}" \
    /bin/bash
xhost -local:root 1>/dev/null 2>&1
