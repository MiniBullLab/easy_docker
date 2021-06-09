FROM vitah/ai_base:1.0.0

RUN apt-get update && apt-get install -y software-properties-common && \
    # 加入opencv软件源
    add-apt-repository --yes ppa:timsc/opencv-3.4 && \
    apt-get -y update --fix-missing

# caffe依赖
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata && \
    apt-get install -y software-properties-common python3-pip \
    python-setuptools python3-setuptools \
    # build-essential pkg-config \ 
    # caffe必备
    libprotobuf-dev libleveldb-dev libsnappy-dev libhdf5-serial-dev protobuf-compiler \
    # 相关依赖库
    libatlas-base-dev libboost-all-dev libgflags-dev libgoogle-glog-dev \
    liblmdb-dev libcv-dev python3-dev \ 
    # opencv有关
    python3-numpy python3-scipy \
    # 并行计算库
    libopenblas-dev \ 
    libopencv-dev python3-skimage

# caffe安装
RUN pip3 install -i https://mirrors.aliyun.com/pypi/simple numpy==1.16.6 && \
    pip3 install -i https://mirrors.aliyun.com/pypi/simple scikit-image==0.17.2 && \
    pip3 install -i https://mirrors.aliyun.com/pypi/simple python-dateutil==2.7.3
RUN echo "\n    Begin install caffe..." && \
    cd /opt && \
    curl -o caffe.zip http://118.31.19.101:8080/software/amba/docker_caffe.zip && \
    unzip caffe.zip && \
    cd /opt/caffe/python && \
    pip3 install -i https://mirrors.aliyun.com/pypi/simple -r requirements.txt && \
    cd /opt/caffe && \
    make all && \
    make pycaffe && \
    echo "export PYTHONPATH=/opt/caffe/python:\$PYTHONPATH">>/etc/bash.bashrc && \
    /bin/bash -c "source /etc/bash.bashrc" && \
    rm -rf /opt/caffe.zip && \
    echo "\n    Install caffe success"

# amba CNN安装
RUN pip3 install -i https://mirrors.aliyun.com/pypi/simple onnx==1.5 && \
    pip3 install -i https://mirrors.aliyun.com/pypi/simple numpy==1.16.6 && \
    pip3 install -i https://mirrors.aliyun.com/pypi/simple scipy==1.5.2 && \
    pip3 install -i https://mirrors.aliyun.com/pypi/simple scikit-image
RUN echo "\n    Begin install Ambarella...\n" && \
    mkdir amba && \
    cd /amba && \
    curl -O http://118.31.19.101:8080/software/amba/Ambarella_Toolchain_CNNGen_Ubuntu-18.04.zip && \
    unzip Ambarella_Toolchain_CNNGen_Ubuntu-18.04.zip && \
    cd /amba/Ubuntu-18.04/ && \
    ./ubuntuToolChain-2.1.7-20190815.ubuntu-18.04 && \
    rm -rf /amba && \
    echo "\n    Install Ambarella success\n"

# 安装PyTorch
RUN echo "\n    Begin install PyTorch..." && \
    pip3 uninstall torch && \
    curl -O http://118.31.19.101:8080/software/easyai/torch-1.0.1-cp36-cp36m-linux_x86_64.whl && \
    pip3 install torch-1.0.1-cp36-cp36m-linux_x86_64.whl && \
    rm torch-1.0.1-cp36-cp36m-linux_x86_64.whl && \
    echo "\n    Install PyTorch success\n"