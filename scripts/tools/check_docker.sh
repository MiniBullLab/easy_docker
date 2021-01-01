#!/usr/bin/env bash

function main() {
   # 检测docker是否安装
   docker --version | grep "Docker version" 1>/dev/null 2>&1
   # shellcheck disable=SC2181
   if [ $? != 0 ]; then
      echo "Docker没有安装，请先安装docker"
      return
   fi

   docker info | grep "ERROR"
   # shellcheck disable=SC2181
   if [ $? == 0 ]; then
      echo "Docker need permission"
   fi
}

main
