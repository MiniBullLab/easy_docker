#!/usr/bin/env bash
easy_path=/home/${USER}/easy_data
if [ ! -d $easy_path ];then
   mkdir $easy_path
else
   echo $easy_path
fi
xhost +
docker run -it --shm-size="2g" --gpus=all --privileged -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix  -v ${easy_path}:/easy_data easy_workspace
