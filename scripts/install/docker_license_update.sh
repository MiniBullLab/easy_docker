#!/usr/bin/env bash
if [ -n "$(docker ps -a -q)" ]; then
   docker stop $(docker ps -a -q)
   echo "stop images"
fi

easy_path=/home/${USER}/easy_data
if [ ! -d $easy_path ];then
   mkdir $easy_path
else
   echo $easy_path
fi

cmd="ssclt --online_bind_license_key --license_key D006-5TZE-UKQJ-SV0S"
sudo docker run -di -v ${easy_path}:/easy_ai --privileged easy_runtime:latest ${cmd}
sleep 2
sudo docker ps -l
docker_id=$(docker ps -l | awk 'NR > 1 {print $1}')
echo $docker_id
if [ -n "${docker_id}" ]; then
    sudo docker commit --author "lipeijie" --message "update ai_runtime" ${docker_id}  easy_runtime:latest
    sleep 2
else
   echo "Failed to update license"
fi

echo "License Update Success!"



