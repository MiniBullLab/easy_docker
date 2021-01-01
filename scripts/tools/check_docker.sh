#!/usr/bin/env bash

function main(){
   GRP_ID=$(id -g)
   GRP_NAME=$(id -g -n)
   USER_ID=$(id -u)
   USER_NAME=$(whoami)

   docker --version | grep "Docker version" 2> /dev/null
   if [ $? != 0 ]; then
      echo "Docker没有安装，请先安装docker"
      return
   fi

   docker info | grep "ERROR"
   if [ $? == 0 ]; then
      echo "Docker need permission"
   fi
}

main
