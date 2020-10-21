FROM nvidia/cuda:10.0-devel-ubuntu18.04

# 系统所需依赖更新
RUN apt-get update 
RUN apt-get install -y git && \
    apt-get install -y wget && \
    apt-get install -y cmake && \
    apt-get install -y sudo && \
    apt-get install -y vim && \
    apt-get install -y unzip 
RUN apt-get install -y libsm6 libxext6 libxrender-dev libglib2.0-0 && \
    apt-get install -y software-properties-common && \
    apt-get install -y python3-pip && \
    pip3 install --upgrade pip 

# cudnn安装
RUN wget http://118.31.19.101:8080/software/gpu/libcudnn7_7.5.1.10-1%2Bcuda10.0_amd64.deb
RUN dpkg -i libcudnn7_7.5.1.10-1+cuda10.0_amd64.deb && \
    rm libcudnn7_7.5.1.10-1+cuda10.0_amd64.deb
RUN wget http://118.31.19.101:8080/software/gpu/libcudnn7-dev_7.5.1.10-1%2Bcuda10.0_amd64.deb 
RUN dpkg -i libcudnn7-dev_7.5.1.10-1+cuda10.0_amd64.deb && \
    rm libcudnn7-dev_7.5.1.10-1+cuda10.0_amd64.deb
RUN wget http://118.31.19.101:8080/software/gpu/libcudnn7-doc_7.5.1.10-1%2Bcuda10.0_amd64.deb
RUN dpkg -i libcudnn7-doc_7.5.1.10-1+cuda10.0_amd64.deb && \
    rm libcudnn7-doc_7.5.1.10-1+cuda10.0_amd64.deb

# caffe所需依赖
RUN add-apt-repository --yes ppa:timsc/opencv-3.4
RUN apt-get update
RUN apt-get install -y build-essential
RUN apt-get install -y pkg-config
RUN apt-get install -y libprotobuf-dev
RUN apt-get install -y libleveldb-dev
RUN apt-get install -y libsnappy-dev
RUN apt-get install -y libhdf5-serial-dev
RUN apt-get install -y protobuf-compiler
RUN apt-get install -y libatlas-base-dev
RUN apt-get install -y libboost-all-dev
RUN apt-get install -y libgflags-dev
RUN apt-get install -y libgoogle-glog-dev
RUN apt-get install -y liblmdb-dev
RUN apt-get install -y libcv-dev
RUN apt-get install -y python3-dev
RUN apt-get install -y python3-numpy
RUN apt-get install -y python3-scipy
RUN apt-get install -y libopenblas-dev
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata
RUN apt-get install -y libopencv-dev
RUN apt-get install -y python3-skimage

# caffe安装
WORKDIR /opt 
RUN wget http://118.31.19.101:8080/software/amba/caffe_ubuntu18.04.zip
RUN unzip caffe_ubuntu18.04.zip 
WORKDIR /opt/caffe
RUN echo "\nCaffe unzip file list:" && ls -C && echo "\n"
RUN echo "\nBegin build caffe...\n" && make
RUN /usr/bin/python3 -m pip install --upgrade pip
RUN cd python/ && pip3 install -i https://mirrors.aliyun.com/pypi/simple/ -r requirements.txt
RUN make pycaffe
RUN echo "\nBuild caffe success.\n"
WORKDIR /
RUN echo "\nOld /etc/profile file content:" && cat -n /etc/profile && echo "\n"
RUN echo "export PATH=/usr/local/cuda/bin:\$PATH">>/etc/profile && \
    echo "export LD_LIBRARY_PATH=/usr/local/cuda/lib64:\$LD_LIBRARY_PATH">>/etc/profile && \
    echo "export PYTHONPATH=/opt/caffe/python:\$PYTHONPATH">>/etc/profile && \
    /bin/bash -c "source /etc/profile" 
RUN echo "\nNew /etc/profile content:" && cat -n /etc/profile && echo "\n"

WORKDIR /
RUN echo "\n Begin install Ambarella...\n"
RUN mkdir amba 
WORKDIR /amba
RUN wget http://118.31.19.101:8080/software/amba/Ambarella_Toolchain_CNNGen_Ubuntu-18.04.tar.gz
RUN tar -zxvf Ambarella_Toolchain_CNNGen_Ubuntu-18.04.tar.gz -C ./ && \
    cd Ubuntu-18.04/ && \
    ./ubuntuToolChain-2.1.7-20190815.ubuntu-18.04 && \
    echo "\n Install Ambarella success"

WORKDIR /
RUN mkdir /easy/
WORKDIR /easy
