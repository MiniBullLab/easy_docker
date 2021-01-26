#!/usr/bin/env bash

AI_IMAGE=ai
WORKSPACE_IMAGE=workspace

function main() {
   if [ "$1" = "workspace" ]; then
      IMAGE_NAME=$WORKSPACE_IMAGE
   else
      IMAGE_NAME=$AI_IMAGE
   fi

   docker-compose build "$IMAGE_NAME"
}

main "$1"
