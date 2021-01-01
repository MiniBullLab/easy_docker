#!/usr/bin/env bash


function main() {
   GRP_ID=$(id -g)
   GRP_NAME=$(id -g -n)
   USER_ID=$(id -u)
   USER_NAME=$(whoami)

   echo "Starting docker container..."
   echo "Current user id:" $USER_ID
   echo "Current user name:" $USER
   echo "Current group id:" $GRP_ID
   echo "Current group name:" $GRP_NAME

   docker info | grep " permission denied"
   if [ $? == 0 ]; then
      echo "Docker need permission"
   fi
}

main
