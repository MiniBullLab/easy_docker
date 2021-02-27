#!/usr/bin/env bash

IMAGE_PREFIX=easy_
BASE_IMAGE=base
LIB_IMAGE_NAME=lib
WORKSPACE_IMAGE_NAME=workspace
RUNTIME_IMAGE_NAME=runtime
BASE_IMAGE_NAME_VERSION=0.1
LIB_IMAGE_NAME_VERSION=0.1

function main() {
   docker-compose build "$BASE_IMAGE" --build-arg CACHEBUST=$(date +%s)
}

main
