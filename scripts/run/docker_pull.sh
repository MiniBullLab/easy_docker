#!/usr/bin/env bash

# 错误码
ERR_MSG_DOCKER_NOT_INSTALL="Docker not installed."
ERR_MSG_DOCKER_SOCKET_PERMISSION="Docker socket permission deny."
ERR_MSG_NVIDIA_DOCKER_NOT_INSTALL="Nvidia docker not installed."
ERR_MSG_DOCKER_NOT_RUNNING="Docker not running."

easy_path=/home/${USER}/easy_data

DOCKER_USER=vitah
AI_IMAGE=ai_runtime
AI_IMAGE_VERSION=1.0.0
WORKSPACE_IMAGE=easy_workspace

IMAGE_NAME=AI_IMAGE

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
   docker image ls | grep "$AI_IMAGE_VERSION" | grep "$DOCKER_USER/$AI_IMAGE" 1>/dev/null 2>&1
   # shellcheck disable=SC2181
   if [ $? != 0 ]; then
      echo "Image $DOCKER_USER/$AI_IMAGE:$AI_IMAGE_VERSION not exist, begin pull..."
      docker pull "$DOCKER_USER/$AI_IMAGE:$AI_IMAGE_VERSION"
      echo "Pull image $$DOCKER_USER/$AI_IMAGE:$AI_IMAGE_VERSION success."
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
