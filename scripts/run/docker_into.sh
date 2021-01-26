#!/usr/bin/env bash

CONTAINER_NAME=${IMAGE_NAME}_$USER

if [ "$1" = "workspace" ]; then
    IMAGE_NAME=$AI_IMAGE
else
    IMAGE_NAME=$WORKSPACE_IMAGE
fi

xhost +local:root 1>/dev/null 2>&1
docker exec \
    -u "$USER" \
    -it "${CONTAINER_NAME}" \
    /bin/bash
xhost -local:root 1>/dev/null 2>&1
