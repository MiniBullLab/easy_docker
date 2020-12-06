#!/usr/bin/env bash

IMAGE_NAME=easy_runtime

function main() {
   USER_NAME=$(whoami)
   RUNTIME_DOCKER="easy_runtime_${USER_NAME}"
   echo "${RUNTIME_DOCKER} is running, begin stop..."
   docker stop $RUNTIME_DOCKER 1>/dev/null
   echo "${RUNTIME_DOCKER} stop success..."
}

main