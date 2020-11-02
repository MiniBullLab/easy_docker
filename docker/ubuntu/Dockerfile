FROM nvidia/cuda:10.0-devel-ubuntu18.04

# 系统所需依赖更新
RUN apt-get -qq update && apt-get install -qq software-properties-common && \
    add-apt-repository --yes ppa:timsc/opencv-3.4 && \
    apt-get -qq update && \
    apt-get install -qq git wget cmake sudo vim unzip curl axel \
    libsm6 libxext6 libxrender-dev libglib2.0-0 software-properties-common python3-pip && \
    pip3 install -q --upgrade pip && \
    # caffe所需依赖
    DEBIAN_FRONTEND=noninteractive apt-get install -qq -y --no-install-recommends tzdata && \
    apt-get install -qq -y build-essential pkg-config libprotobuf-dev \
    libleveldb-dev libsnappy-dev libhdf5-serial-dev protobuf-compiler \
    libatlas-base-dev libboost-all-dev libgflags-dev libgoogle-glog-dev \
    liblmdb-dev libcv-dev python3-dev python3-numpy python3-scipy \
    libopenblas-dev libopencv-dev python3-skimage

# amba安装
RUN echo "\n    Begin install Ambarella...\n" && \
    mkdir amba && \
    cd /amba && \
    curl -O http://118.31.19.101:8080/software/amba/Ambarella_Toolchain_CNNGen_Ubuntu-18.04.tar.gz && \
    tar -zxvf Ambarella_Toolchain_CNNGen_Ubuntu-18.04.tar.gz -C ./ && \
    cd /amba/Ubuntu-18.04/ && \
    ./ubuntuToolChain-2.1.7-20190815.ubuntu-18.04 && \
    echo "\n    Install Ambarella success\n"

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

# caffe安装
RUN echo "\n    Begin install caffe..." && \
    cd /opt && \
    curl -o caffe.zip http://118.31.19.101:8080/software/amba/caffe_ubuntu18.04.zip && \
    unzip caffe.zip && \
    cd /opt/caffe && \
    make && \
    cd /opt/caffe/python && \
    pip install --ignore-installed leveldb && \
    pip3 install -i https://mirrors.aliyun.com/pypi/simple/ -r requirements.txt && \
    cd /opt/caffe && make pycaffe && \
    pip3 install python-dateutil --upgrade && \
    echo "export PYTHONPATH=/opt/caffe/python:\$PYTHONPATH">>/etc/profile && \
    /bin/bash -c "source /etc/profile" && \
    echo "\n    Install caffe success"

# 安装PyTorch
RUN echo "\n    Begin install PyTorch..." && \
    pip3 uninstall torch && \
    curl -O http://118.31.19.101:8080/software/easyai/torch-1.0.1-cp36-cp36m-linux_x86_64.whl && \
    pip3 install torch-1.0.1-cp36-cp36m-linux_x86_64.whl && \
    rm torch-1.0.1-cp36-cp36m-linux_x86_64.whl && \
    echo "\n    Install PyTorch success\n"

# 安装easy_ai
RUN echo "\n    Begin install easy_ai..." && \
    curl -O http://118.31.19.101:8080/software/easyai/easyai-0.3-py2.py3-none-any.whl  \
    -O http://118.31.19.101:8080/software/easyai/easy_converter-0.2-py2.py3-none-any.whl  \
    -O http://118.31.19.101:8080/software/easyai/easy_tools-0.2-py2.py3-none-any.whl && \ 
    pip3 install -i https://mirrors.aliyun.com/pypi/simple easyai-0.3-py2.py3-none-any.whl && \
    pip3 install -i https://mirrors.aliyun.com/pypi/simple easy_converter-0.2-py2.py3-none-any.whl && \
    pip3 install -i https://mirrors.aliyun.com/pypi/simple easy_tools-0.2-py2.py3-none-any.whl && \
    rm easyai-0.3-py2.py3-none-any.whl && \
    rm easy_converter-0.2-py2.py3-none-any.whl && \
    rm easy_tools-0.2-py2.py3-none-any.whl && \
    echo "export PYTHONPATH=/easy/easy_ai:$PYTHONPATH">>/etc/profile && \
    /bin/bash -c "source /etc/profile" && \
    echo "\n    Install easy_ai success\n"

RUN echo "export PATH=/usr/local/cuda/bin:\$PATH">>/etc/profile && \
    echo "export LD_LIBRARY_PATH=/usr/local/cuda/lib64:\$LD_LIBRARY_PATH">>/etc/profile && \
    /bin/bash -c "source /etc/profile"

RUN mkdir /easy
WORKDIR /easy
