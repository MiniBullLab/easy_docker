FROM nvidia/cuda:10.0-devel-ubuntu18.04

ARG CACHE_DATETIME=1

RUN echo 'Begin build base image...'

RUN rm /etc/apt/sources.list.d/cuda.list && rm /etc/apt/sources.list.d/nvidia-ml.list

# 系统所需依赖更新
RUN apt-get update && apt-get install -y software-properties-common && \
    add-apt-repository "deb http://security.ubuntu.com/ubuntu xenial-security main" && \
    apt-get update && \
    apt-get install -y git wget sudo vim unzip curl axel gcc g++ \
    libsm6 libxext6 libxrender-dev libglib2.0-0 python3-pip && \
    pip3 install install -i https://mirrors.aliyun.com/pypi/simple --upgrade pip && \
    apt-get install -y autoconf automake libtool pkg-config build-essential libasio-dev libtinyxml2-dev libncurses5-dev libboost-all-dev

# 设置系统编码
RUN apt-get install -y language-pack-zh-han* language-pack-kde-zh-han*
RUN locale-gen zh_CN.UTF-8 && \
    echo "export LANG=\"zh_CN.UTF-8\"" >> /etc/default/locale && \
    echo "export LANGUAGE=\"zh_CN:zh:en_US:en\"" >> /etc/default/locale && locale
ENV LANG C.utf8

# 安装Cmake
RUN apt-get install -y libssl-dev && \
    apt-get remove -y cmake && \
    curl -L -O http://118.31.19.101:8080/software/utility/cmake-3.14.0.tar.gz && \
    tar -vxf cmake-3.14.0.tar.gz && \
    cd CMake-3.14.0/ && \
    ./bootstrap && \
    make && \
    sudo make install && \
    cmake --version && \
    rm -rf /cmake-3.14.0.tar.gz  /CMake-3.14.0

RUN echo "export PATH=/usr/local/cuda/bin:\$PATH">>/etc/bash.bashrc && \
    echo "export LD_LIBRARY_PATH=/usr/local/cuda/lib64:\$LD_LIBRARY_PATH">>/etc/bash.bashrc && \
    /bin/bash -c "source /etc/bash.bashrc"

# cudnn安装
RUN  echo "\n    Begin install cudnn..." && \
    dpkg --purge libcudnn7-doc && \
    dpkg --purge libcudnn7-dev && \
    dpkg --purge libcudnn7 && \
    curl -o libcudnn.deb http://118.31.19.101:8080/software/gpu/libcudnn7_7.5.1.10-1+cuda10.0_amd64.deb  \ 
    -o libcudnn-dev.deb http://118.31.19.101:8080/software/gpu/libcudnn7-dev_7.5.1.10-1+cuda10.0_amd64.deb \
    -o libcudnn-doc.deb http://118.31.19.101:8080/software/gpu/libcudnn7-doc_7.5.1.10-1+cuda10.0_amd64.deb && \
    dpkg -i libcudnn.deb && \
    dpkg -i libcudnn-dev.deb && \
    dpkg -i libcudnn-doc.deb && \
    rm libcudnn.deb libcudnn-dev.deb libcudnn-doc.deb && \
    echo "\n    Install cudnn success\n"

RUN echo "Build base image success. $CACHE_DATETIME"