#!/usr/bin/env bash

# 错误码
CODE_DOCKER_NOT_INSTALL=10001

function envCheckFailedAndExit() {
   echo "Error code:$1"
   exit 1
}

# 检测Docker是否安装
function checkDockerInstall() {
   docker --version | grep "Docker version" 1>/dev/null 2>&1
   # shellcheck disable=SC2181
   if [ $? != 0 ]; then
      envCheckFailedAndExit $CODE_DOCKER_NOT_INSTALL
   fi
}

function main() {
   checkDockerInstall

   docker info | grep "ERROR"
   # shellcheck disable=SC2181
   if [ $? == 0 ]; then
      echo "Docker need permission"
   fi
}

main
