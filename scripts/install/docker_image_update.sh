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

chmod +x ${easy_path}/package/update_install.sh
cmd="/easy_ai/package/update_install.sh"
docker run -di -v ${easy_path}:/easy_ai --privileged easy_runtime:latest ${cmd}
sleep 20
if [ $? -ne 0 ]; then
    echo "Failed to update easy_runtime"
    exit 1
fi
docker ps -l
docker_id=$(docker ps -l | awk 'NR > 1 {print $1}')
echo $docker_id
if [ -n "${docker_id}" ]; then
    docker commit --author "lipeijie" --message "update ai_runtime" ${docker_id}  easy_runtime:latest
    sleep 2
else
   echo "Failed to save"
fi

echo "Update Success!"



