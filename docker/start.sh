#!/usr/bin/env bash

function main(){
    # 当前用户ID
    USER_ID=$(id -u)
    USER_NAME=$(whoami)
    GRP=$(id -g -n)
    GRP_ID=$(id --group)

    echo  "Starting docker container..."
    echo  "Current user id:" $USER_ID 
    echo  "Current user name:" $USER_NAME
    echo "Current group id:" $GRP_ID
    echo "Current group name:"$GRP
}

main