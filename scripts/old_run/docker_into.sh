#!/usr/bin/env bash

AI_IMAGE=easy_runtime
WORKSPACE_IMAGE=easy_workspace

if [ "$1" = "workspace" ]; then
    IMAGE_NAME=$WORKSPACE_IMAGE
else
    IMAGE_NAME=$AI_IMAGE
fi

CONTAINER_NAME=${IMAGE_NAME}_$USER

xhost +local:root 1>/dev/null 2>&1
docker exec \
    -u "$USER" \
    -it "${CONTAINER_NAME}" \
    /bin/bash
xhost -local:root 1>/dev/null 2>&1
