#!/usr/bin/env bash

DOCKER_USER=vitah
AI_IMAGE=ai_runtime
AI_IMAGE_VERSION=1.0.0
SAVED_FILE_NAME="${DOCKER_USER}_${AI_IMAGE}_${AI_IMAGE_VERSION}.tar"

function saveRuntimeImage() {
   docker image ls | grep "$AI_IMAGE_VERSION" | grep "$DOCKER_USER/$AI_IMAGE" 1>/dev/null 2>&1
   # shellcheck disable=SC2181
   if [ $? != 0 ]; then
      echo "Image $DOCKER_USER/$AI_IMAGE:$AI_IMAGE_VERSION not exist!"
   else
      docker save -o $SAVED_FILE_NAME $DOCKER_USER/$AI_IMAGE:$AI_IMAGE_VERSION
   fi
}

function main() {
   saveRuntimeImage
}

main
