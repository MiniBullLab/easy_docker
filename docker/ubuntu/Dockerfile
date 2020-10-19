FROM nvidia/cuda:10.0-devel-ubuntu18.04

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

RUN wget http://118.31.19.101:8080/software/gpu/libcudnn7_7.5.1.10-1%2Bcuda10.0_amd64.deb
RUN dpkg -i libcudnn7_7.5.1.10-1+cuda10.0_amd64.deb && \
    rm libcudnn7_7.5.1.10-1+cuda10.0_amd64.deb

RUN wget http://118.31.19.101:8080/software/gpu/libcudnn7-dev_7.5.1.10-1%2Bcuda10.0_amd64.deb 
RUN dpkg -i libcudnn7-dev_7.5.1.10-1+cuda10.0_amd64.deb && \
    rm libcudnn7-dev_7.5.1.10-1+cuda10.0_amd64.deb

RUN wget http://118.31.19.101:8080/software/gpu/libcudnn7-doc_7.5.1.10-1%2Bcuda10.0_amd64.deb
RUN dpkg -i libcudnn7-doc_7.5.1.10-1+cuda10.0_amd64.deb && \
    rm libcudnn7-doc_7.5.1.10-1+cuda10.0_amd64.deb

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

RUN wget http://118.31.19.101:8080/software/amba/caffe_ubuntu18.04.zip
RUN unzip caffe_ubuntu18.04.zip
WORKDIR /caffe
RUN echo "Build caffe..." && make
RUN cd python/ && pip3 install -i https://pypi.tuna.tsinghua.edu.cn/simple -r requirements.txt
RUN make pycaffe

WORKDIR /root
RUN ls -a && echo "Add caffe python path to .bashrc:" && \
    echo "export PYTHONPATH=/caffe/python:\$PYTHONPATH">>.bashrc && \
    /bin/bash -c "source /root/.bashrc" 
RUN echo "/root/.bash content:" && cat -n .bashrc

WORKDIR /
RUN mkdir amba/ 
WORKDIR /amba/
RUN wget http://118.31.19.101:8080/software/amba/Ambarella_Toolchain_CNNGen_Ubuntu-18.04.tar.gz
RUN tar -zxvf Ambarella_Toolchain_CNNGen_Ubuntu-18.04.tar.gz -C ./ && \
    cd Ubuntu-18.04/ && \
    ./ubuntuToolChain-2.1.7-20190815.ubuntu-18.04

WORKDIR /
RUN mkdir /easy/
WORKDIR /easy
