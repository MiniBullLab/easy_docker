#!/usr/bin/env bash

easy_path=/Users/${USER}/easy_data
# easy_path=/home/${USER}/easy_data


function main() {
   USER_ID=$(id -u)
   USER=$(whoami)
   GRP=$(id -g -n)
   GRP_ID=$(id --group)

   echo "Starting docker container..."
   echo "Current user id:" $USER_ID
   echo "Current user name:" $USER
   echo "Current group id:" $GRP_IDP
   echo "Current group name:"$GRP

   if [ ! -d $easy_path ]; then
      echo "easy_path not exist, create dir ${easy_path}"
      mkdir $easy_path
   fi

    EASY_RUNTIME="easy_runtime_${USER}"
    echo EASY_RUNTIME
    docker ps -a --format "{{.Names}}" | grep "$EASY_RUNTIME" 1>/dev/null
    if [ $? == 0 ]; then
        echo "aaa" 
        docker stop $APOLLO_DEV 1>/dev/null
        docker rm -v -f $APOLLO_DEV 1>/dev/null
    fi

   # docker run -it --shm-size=2g \
   #    -e DOCKER_USER_ID=$USER_ID \
   #    -e DOCKER_GRP="$GRP" \
   #    -e DOCKER_GRP_ID=$GRP_ID \
   #    -v ${easy_path}:/easy easy_ubuntu

   # docker run -it --shm-size="2g" --gpus=all -v ${easy_path}:/easy easy_ubuntu
}

main
