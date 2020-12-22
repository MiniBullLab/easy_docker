

### 安装

* 安装docker
    
    目前支持操作系统为：
    * ubuntu18.04
    * centos7

    具体安装：
    ```
    cd scripts
    ./xxx_docker_install.sh
    ```

### 使用

* 首先需要启动`docker`服务：

    ```shell
    systemctl start docker
    ```

* 查看docker服务状态:
 
    ```shell
    systemctl status docker
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
* 停止docker镜像

    ```
    ./scripts/run/docker_stop.sh
    ```