#!/usr/bin/env bash

IMAGE_NAME=easy_runtime

function main() {
   local user_name
   user_name=$(whoami)
   local runtime_docker_name="${IMAGE_NAME}_${user_name}"

   echo "Begin stop container ${runtime_docker_name}..."
   docker_ps_result=$(docker ps -f name="${runtime_docker_name}" | grep "${runtime_docker_name}")
   if [ -n "$docker_ps_result" ]; then
      echo "Docker container ${runtime_docker_name} is running, begin stop..."
      docker stop "$runtime_docker_name" 1>/dev/null
      echo "Docker container ${RUNTIME_DOCKER} stop success."
   else
      echo "Docker container ${RUNTIME_DOCKER} not in running."
   fi
}

main
