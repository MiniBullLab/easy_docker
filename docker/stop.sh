#!/usr/bin/env bash

AI_IMAGE=easy_ai
WORKSPACE_IMAGE=easy_workspac
IMAGE_NAME=easy_ai

function main() {
   if [ "$1" = "workspace" ]; then
      IMAGE_NAME=$WORKSPACE_IMAGE
   else
      IMAGE_NAME=$AI_IMAGE
   fi

   local user_name
   user_name=$(whoami)
   local runtime_docker_name="${IMAGE_NAME}_${user_name}"
   docker_ps_result=$(docker ps -f name="${runtime_docker_name}" | grep "${runtime_docker_name}")
   if [ -n "$docker_ps_result" ]; then
      echo "Docker container ${runtime_docker_name} is running, begin stop..."
      docker stop "$runtime_docker_name" 1>/dev/null
      echo "Docker container ${runtime_docker_name} stop success."
   else
      echo "Docker container ${runtime_docker_name} not in running."
   fi
}

main "$1"
