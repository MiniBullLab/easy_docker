

### 安装

本机需要安装`docker`以及`docker-compose`。
* 安装docker

    ```
    cd scripts/install
    ./xxx_docker_install.sh
    ```

* 安装docker-compose
    
    [docker-compose](./ubuntu18.04安装docker-compose.md)

### 使用

首先需要启动`docker`服务：
```shell
systemctl start docker
```

 删除机器上其他docker镜像

```
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
docker rmi $(docker images -q)
```

`git clone` easy_docker项目到本地，然后：
```shell
# 进入到easy_docker的docker目录
$ cd ~/easy_docker/docker

# docker镜像编译
$ make build

# docker镜像commit
docker ps
docker commit --author "lipeijie" --message "update cudnn" 98d602eb1f9c easy_ubuntu:latest

# docker镜像打包
docker save -o easy_ubuntu.tar nvidia/cuda:10.0-devel-ubuntu18.04 easy_ubuntu:latest
``` 