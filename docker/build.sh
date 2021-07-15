#!/usr/bin/env bash

EASY_PATH=/home/${USER}/easy_data
DOCKER_USER=minbull
IMAGE_PREFIX=ai_

RUNTIME_VERSION=1.0.0
RUNTIME_IMAGE=runtime
RUNTIME_IMAGE_FULL="$IMAGE_PREFIX$RUNTIME_IMAGE"

BASE_IMAGE_VERSION=1.0.0
BASE_IMAGE=base
BASE_IMAGE_FULL="$IMAGE_PREFIX$BASE_IMAGE"

AI_LIB_IMAGE_VERSION=1.0.0
AI_LIB_IMAGE=runtime_lib
AI_LIB_IMAGE_FULL="$IMAGE_PREFIX$AI_LIB_IMAGE"

WORKSPACE_IMAGE=workspace

function dockerLogin() {
   result=$(docker login)
   if [[ "$result" =~ "Login Succeeded" ]]; then
      echo "Docker login successed."
   fi
}

function buildRuntime() {
   echo "Begin build base image..."
   docker-compose build "$BASE_IMAGE"
   docker tag $BASE_IMAGE_FULL $DOCKER_USER/$BASE_IMAGE_FULL:$BASE_IMAGE_VERSION
   echo "Build base image success."

   echo "Begin build ai_lib image..."
   docker-compose build $AI_LIB_IMAGE
   docker tag $AI_LIB_IMAGE_FULL $DOCKER_USER/$AI_LIB_IMAGE_FULL:$AI_LIB_IMAGE_VERSION
   echo "Build ai_lib image success."

   echo "Begin build runtime image..."
   docker-compose build $RUNTIME_IMAGE
   docker tag $RUNTIME_IMAGE_FULL $DOCKER_USER/$RUNTIME_IMAGE_FULL:$RUNTIME_VERSION
   echo "Build runtime image success."
}

function buildWorkspace() {
   echo "Begin build base image..."
   docker-compose build "$BASE_IMAGE"
   echo "Build base image success."

   echo "Begin build lib image..."
   docker-compose build workspace_lib
   echo "Build lib image success."

   echo "Begin build workspace image..."
   docker-compose build workspace
   echo "Build workspace image success."
}

function main() {
   if [ "$1" = "workspace" ]; then
      buildWorkspace
   else
      buildRuntime
   fi
}
main "$1"
