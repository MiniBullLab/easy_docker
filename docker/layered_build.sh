#!/usr/bin/env bash

DOCKER_USER=vitah
IMAGE_PREFIX=easy_

BASE_IMAGE_VERSION=1.0.0
BASE_IMAGE=base
BASE_IMAGE_FULL=$IMAGE_PREFIX$BASE_IMAGE

LIB_IMAGE_VERSION=1.0.0
LIB_IMAGE=lib
LIB_IMAGE_FULL=$IMAGE_PREFIX$LIB_IMAGE

WORKSPACE_IMAGE_VERSION=1.0.0
WORKSPACE_IMAGE=workspace
WORKSPACE_IMAGE_FULL=$IMAGE_PREFIX$WORKSPACE_IMAGE

RUNTIME_IMAGE_VERSION=1.0.0
RUNTIME_IMAGE=workspace
RUNTIME_IMAGE_FULL=$IMAGE_PREFIX$RUNTIME_IMAGE

function dockerLogin() {
   result=$(docker login)
   if [[ "$result" =~ "Login Succeeded" ]]; then
      echo "Docker login successed."
   fi
}

function main() {
   echo "Begin build base image..."
   docker-compose build "$BASE_IMAGE"
   docker tag $BASE_IMAGE_FULL $DOCKER_USER/$BASE_IMAGE_FULL:$BASE_IMAGE_VERSION
   echo "Build base image success."

   echo "Begin build lib image..."
   docker-compose build $LIB_IMAGE
   docker tag $LIB_IMAGE_FULL $DOCKER_USER/$LIB_IMAGE_FULL:$LIB_IMAGE_VERSION
   echo "Build lib image success."

   echo "Begin build runtime image..."
   docker-compose build $RUNTIME_IMAGE
   #docker tag $RUNTIME_IMAGE_FULL $DOCKER_USER/$RUNTIME_IMAGE_FULL:$RUNTIME_IMAGE_VERSION
   echo "Build runtime image success."

   echo "Begin build workspace image..."
   docker-compose build $WORKSPACE_IMAGE
   #docker tag $WORKSPACE_IMAGE_FULL $DOCKER_USER/$WORKSPACE_IMAGE_FULL:$WORKSPACE_IMAGE_VERSION
   echo "Build workspace image success."
}

main
