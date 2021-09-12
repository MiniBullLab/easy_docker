#!/usr/bin/env bash

DOCKER_USER=minbull
IMAGE_PREFIX=ai_

RUNTIME_VERSION=1.0.1
RUNTIME_IMAGE=runtime
RUNTIME_IMAGE_FULL="$IMAGE_PREFIX$RUNTIME_IMAGE"

SAVED_FILE_NAME="${DOCKER_USER}_${RUNTIME_IMAGE_FULL}_${RUNTIME_VERSION}.tar"

function saveRuntimeImage() {
   docker image ls | grep "$RUNTIME_IMAGE_FULL" | grep "$DOCKER_USER/$RUNTIME_IMAGE_FULL" 1>/dev/null 2>&1
   # shellcheck disable=SC2181
   if [ $? != 0 ]; then
      echo "Image $DOCKER_USER/$RUNTIME_IMAGE_FULL:$RUNTIME_VERSION not exist!"
   else
      echo "Image $DOCKER_USER/$RUNTIME_IMAGE_FULL:$RUNTIME_VERSION is saving..."
      docker save -o $SAVED_FILE_NAME $DOCKER_USER/$RUNTIME_IMAGE_FULL:$RUNTIME_VERSION
      echo "Image $DOCKER_USER/$RUNTIME_IMAGE_FULL:$RUNTIME_VERSION saved success, file is: $SAVED_FILE_NAME"
   fi
}

function main() {
   saveRuntimeImage
}

main
