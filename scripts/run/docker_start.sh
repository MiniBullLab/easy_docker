#!/usr/bin/env bash

# 错误码
ERR_MSG_DOCKER_NOT_INSTALL="Docker not installed."
ERR_MSG_DOCKER_SOCKET_PERMISSION="Docker socket permission deny."
ERR_MSG_NVIDIA_DOCKER_NOT_INSTALL="Nvidia docker not installed."
ERR_MSG_DOCKER_NOT_RUNNING="Docker not running."

easy_path=/home/${USER}/easy_data

IMAGE_NAME=easy_runtime
DOCKER_CMD=docker

# 运行环境检测失败，打印错误码并且退出
function envCheckFailedAndExit() {
   echo "EasyAI runtime environment error."
   echo "Error msg: $1"
   exit 1
}

# 检测Docker是否安装
function checkDockerInstall() {
   docker --version | grep "Docker version" 1>/dev/null 2>&1
   # shellcheck disable=SC2181
   if [ $? != 0 ]; then
      envCheckFailedAndExit "$ERR_MSG_DOCKER_NOT_INSTALL"
   fi
}

# 检测nvidia-docker是否安装
function checkNvidiaDocker() {
   nvidia-docker -v | grep 'Docker version' 1>/dev/null 2>&1
   # shellcheck disable=SC2181
   if [ $? != 0 ]; then
      envCheckFailedAndExit "$ERR_MSG_NVIDIA_DOCKER_NOT_INSTALL"
   fi
}

# 检验docker是否在运行
function checkDockerIsRunning() {
   checkResult=$(docker info --format '{{json .}}' | grep "Is the docker daemon running")
   if [ -n "$checkResult" ]; then
      envCheckFailedAndExit "$ERR_MSG_DOCKER_NOT_RUNNING"
   fi
}

# 检测docker socket权限
function checkDockerPermission() {
   checkResult=$(docker info --format '{{json .}}' | grep "Got permission denied while trying to connect to the Docker daemon socket")
   if [ -n "$checkResult" ]; then
      envCheckFailedAndExit "$ERR_MSG_DOCKER_SOCKET_PERMISSION"
   fi
}

# 检测运行环境
function checkRuntimeEnvironment() {
   echo "Begin check EasyAI runtime environment..."
   checkDockerInstall
   checkDockerPermission
   checkDockerIsRunning
   checkNvidiaDocker
   echo "EasyAI runtime environment OK"
   echo ""
}

# 启动加密狗
function startSenseshield() {
   echo "Begin start senseshield..."
   docker exec "$RUNTIME_DOCKER" sudo /usr/lib/senseshield/senseshield
   ps_result=$(docker exec "$RUNTIME_DOCKER" ps -aux | grep senseshield)
   if [ -z "$ps_result" ]; then
      echo "Start senseshield failed."
      docker stop "$RUNTIME_DOCKER" 1>/dev/null
      docker rm -v -f "$RUNTIME_DOCKER" 1>/dev/null
      exit 1
   fi
   echo "Start senseshield success."
   echo ""
}

# 在docker容器中创建对应的非root用户
function createDockerUser() {
   if [ "${USER}" != "root" ]; then
      echo ""
      echo "Current user is not root, begin to create docker user..."
      docker exec "${RUNTIME_DOCKER}" bash -c '/scripts/add_user.sh'
      # shellcheck disable=SC2181
      if [ $? == 0 ]; then
         echo "Create docker user success."
         echo ""
      else
         echo "Create docker user failed."
         exit 1
      fi
   fi
}

function main() {
   GRP_ID=$(id -g)
   GRP_NAME=$(id -g -n)
   USER_ID=$(id -u)
   USER_NAME=$(whoami)
   echo "Group id=$GRP_ID name=$GRP_NAME"
   echo "User id=$USER_ID name=$USER"
   echo ""

   checkRuntimeEnvironment

   if [ ! -d "$easy_path" ]; then
      echo "easy_path not exist, create dir ${easy_path}"
      mkdir "$easy_path"
   fi

   RUNTIME_DOCKER="easy_runtime_${USER_NAME}"
   docker ps -a --format "{{.Names}}" | grep "$RUNTIME_DOCKER" 1>/dev/null
   # shellcheck disable=SC2181
   if [ $? == 0 ]; then
      echo "${RUNTIME_DOCKER} is running, stop and remove..."
      docker stop "$RUNTIME_DOCKER" 1>/dev/null
      docker rm -v -f "$RUNTIME_DOCKER" 1>/dev/null
      echo "${RUNTIME_DOCKER} stop and remove success"
      echo ""
   fi

   echo "Starting docker container ${RUNTIME_DOCKER} ..."

   ${DOCKER_CMD} run -it --shm-size="2g" --gpus=all -d --privileged --name "$RUNTIME_DOCKER" \
      -e DOCKER_IMG=$IMAGE_NAME \
      -e DOCKER_USER="$USER_NAME" \
      -e DOCKER_USER_ID="$USER_ID" \
      -e DOCKER_GRP="$GRP_NAME" \
      -e DOCKER_GRP_ID="$GRP_ID" \
      -v "${easy_path}":/easy_ai \
      $IMAGE_NAME \
      /bin/bash
   # shellcheck disable=SC2181
   if [ $? -ne 0 ]; then
      echo "Failed to start docker container \"${RUNTIME_DOCKER}\" based on image: $IMAGE_NAME"
      exit 1
   fi

   createDockerUser
   startSenseshield

   echo "Finished setting up EasyAi docker environment."
   echo "Now you can enter with: bash docker_into.sh"
}

main
