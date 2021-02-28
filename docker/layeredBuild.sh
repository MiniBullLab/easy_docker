#!/usr/bin/env bash

DOCKER_USER=vitah
IMAGE_PREFIX=easy_
BASE_IMAGE=base
BASE_IMAGE_FULL_NAME=$IMAGE_PREFIX$BASE_IMAGE
LIB_IMAGE_NAME=lib
WORKSPACE_IMAGE_NAME=workspace
RUNTIME_IMAGE_NAME=runtime
BASE_IMAGE_VERSION=1.0.0
LIB_IMAGE_VERSION=1.0.0

function dockerLogin() {
   result=$(docker login)
   if [[ "$result" =~ "Login Succeeded" ]]; then
      echo "Docker login successed."
   fi
}

function main() {
   docker-compose build "$BASE_IMAGE"
   docker tag $BASE_IMAGE_FULL_NAME $DOCKER_USER/$BASE_IMAGE_FULL_NAME:$BASE_IMAGE_VERSION
}

main
