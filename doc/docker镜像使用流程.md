

### 安装

* 安装docker

    ```
    cd scripts
    ./docker_install.sh
    ```

### 使用

* 首先需要启动`docker`服务：

    ```shell
    systemctl start docker
    ```

* 删除机器上其他docker镜像

    ```
    docker stop $(docker ps -a -q)
    docker rm $(docker ps -a -q)
    docker rmi $(docker images -q)
    ```

* docker镜像加载

    ```
    docker load -i easy_xxx.tar
    ```

* 启动docker镜像

    ```
    ./scripts/run/docker_start.sh
    ```
* 进入docker镜像

    ```
    ./scripts/run/docker_into.sh
    ```
* 启动docker镜像

    ```
    ./scripts/run/docker_stop.sh
    ```