#!/usr/bin/env bash

easy_path=/home/${USER}/easy_data

IMAGE_NAME=easy_runtime
DOCKER_CMD=docker

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

   if [ ! -d $easy_path ]; then
      echo "easy_path not exist, create dir ${easy_path}"
      mkdir $easy_path
   fi

   RUNTIME_DOCKER="easy_runtime_${USER_NAME}"
   docker ps -a --format "{{.Names}}" | grep "$RUNTIME_DOCKER" 1>/dev/null
    
    # 判断上次命令是否执行成功?表示上一次的执行结果
    if [ $? == 0 ]; then
        echo "${RUNTIME_DOCKER} is running, stop and remove ..."
        docker stop $RUNTIME_DOCKER 1>/dev/null
        docker rm -v -f $RUNTIME_DOCKER 1>/dev/null
        echo "${RUNTIME_DOCKER} stop and remove success..."
    fi

   echo "Starting docker container ${RUNTIME_DOCKER} ..."

   ${DOCKER_CMD} run -it --shm-size="2g" --gpus=all -d --privileged --name $RUNTIME_DOCKER \
      -e DOCKER_IMG=$IMAGE_NAME \
      -e DOCKER_USER=$USER_NAME \
      -e DOCKER_USER_ID=$USER_ID \
      -e DOCKER_GRP=$GRP_NAME \
      -e DOCKER_GRP_ID=$GRP_ID \
      -v ${easy_path}:/easy_ai \
      $IMAGE_NAME \
      /bin/bash

   if [ $? -ne 0 ];then
        echo "Failed to start docker container \"${RUNTIME_DOCKER}\" based on image: $IMAGE_NAME"
        exit 1
   fi

   if [ "${USER}" != "root" ]; then
      echo "Runtime is not root, begin to create user..."
      docker exec $RUNTIME_DOCKER bash -c '/scripts/add_user.sh'
      echo "Docker user create success"
   fi

   echo "Check senseshield..."
   docker exec $RUNTIME_DOCKER ps -aux | grep sense
   if [ $? == 0 ]; then
      echo "Check senseshield failed."
      docker stop $RUNTIME_DOCKER 1>/dev/null
      docker rm -v -f $RUNTIME_DOCKER 1>/dev/null 
   else
      echo "Finished setting up EasyAi docker environment. Now you can enter with: \nbash docker_into.sh"
   fi
}

main