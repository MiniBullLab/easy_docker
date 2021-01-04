#!/usr/bin/env bash

# 错误码
ERR_CODE_DOCKER_NOT_INSTALL=10001
ERR_CODE_DOCKER_SOCKET_PERMISSION=10002
ERR_CODE_NVIDIA_DOCKER_NOT_INSTALL=10003

# 运行环境检测失败，打印错误码并且退出
function envCheckFailedAndExit() {
   echo "Error code: $1"
   exit 1
}

# 检测Docker是否安装
function checkDockerInstall() {
   docker --version | grep "Docker version" 1>/dev/null 2>&1
   # shellcheck disable=SC2181
   if [ $? != 0 ]; then
      envCheckFailedAndExit $ERR_CODE_DOCKER_NOT_INSTALL
   fi
}

function checkNvidiaDocker() {
   nvidia-docker -v | grep 'Docker version' 1>/dev/null 2>&1
   # shellcheck disable=SC2181
   if [ $? -eq 0 ]; then
      envCheckFailedAndExit $ERR_CODE_NVIDIA_DOCKER_NOT_INSTALL
   fi
}

# 检测docker权限
function checkDockerPermission() {
   docker info | grep "ERROR: Got permission denied while trying to connect to the Docker daemon socket" 1>/dev/null 2>&1
   # shellcheck disable=SC2181
   if [ $? == 0 ]; then
      envCheckFailedAndExit $ERR_CODE_DOCKER_SOCKET_PERMISSION
   fi
}

function main() {
   checkDockerInstall
   checkDockerPermission
   checkNvidiaDocker
}

main
