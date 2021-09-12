#!/usr/bin/env bash

DOCKER_USER=minbull
IMAGE_PREFIX=ai_

RUNTIME_VERSION=1.0.1
RUNTIME_IMAGE=runtime
RUNTIME_IMAGE_FULL="$IMAGE_PREFIX$RUNTIME_IMAGE"

# 错误码
ERR_MSG_DOCKER_NOT_INSTALL="Docker not installed."
ERR_MSG_DOCKER_SOCKET_PERMISSION="Docker socket permission deny."
ERR_MSG_NVIDIA_DOCKER_NOT_INSTALL="Nvidia docker not installed."
ERR_MSG_DOCKER_NOT_RUNNING="Docker not running."

# 运行环境检测失败，打印错误码并且退出
function envCheckFailedAndExit() {
   echo "EasyAI environment error."
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

function pullRuntimeImageToLocal() {
   docker image ls | grep "$RUNTIME_VERSION" | grep "$DOCKER_USER/$RUNTIME_IMAGE_FULL" 1>/dev/null 2>&1
   # shellcheck disable=SC2181
   if [ $? != 0 ]; then
      echo "Image $DOCKER_USER/$RUNTIME_IMAGE_FULL:$RUNTIME_VERSION not exist, begin pull..."
      docker pull "$DOCKER_USER/$RUNTIME_IMAGE_FULL:$RUNTIME_VERSION"
      echo "Pull image $DOCKER_USER/$RUNTIME_IMAGE_FULL:$RUNTIME_VERSION success."
   else
      echo "Runtime image existed"
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
   echo "Begin check EasyAI environment..."
   checkDockerInstall
   checkDockerPermission
   checkDockerIsRunning
   checkNvidiaDocker
   echo "EasyAI environment OK"
   echo ""
}

function main() {
   pullRuntimeImageToLocal
}

main
