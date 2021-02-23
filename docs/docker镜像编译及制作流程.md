

### 安装环境

本机需要安装`docker`以及`docker-compose`。
* 安装docker

    ```
    cd scripts/install
    ./xxx_docker_install.sh
    ```

* 安装docker-compose
    
    [docker-compose](./ubuntu18.04安装docker-compose.md)

* 重启系统或者注销用户

### 启动`docker`服务：（非必要步骤）
``shell
systemctl start docker
```

### 删除机器上其他docker镜像（非必要步骤）
```shell
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
docker rmi $(docker images -q)
```

### 编译镜像
1. `git clone https://github.com/MiniBullLab/easy_docker.git` 项目到本地
2. 进入到easy_docker的docker目录
```shell
cd easy_docker/docker
```
3. 目前有2个镜像，easy_ai和easy_workspace，在docker 目录，运行 build.sh 脚本

    命令： ./build.sh 镜像名 （镜像名为 ai 或者 workspace ，如果不指定镜像名，默认选择 ai 镜像）

    * 编译ai镜像: 
        ./build.sh ai
    * 编译workspace镜像: 
        /.build.sh workspace

### docker修改镜像保存（非必要步骤）
```
docker ps
docker commit --author "lipeijie" --message "update easyai" 98d602eb1f9c easy_runtime:latest
```

### docker镜像打包
docker save -o easy_runtime.tar nvidia/cuda:10.0-devel-ubuntu18.04 easy_runtime:latest
```
