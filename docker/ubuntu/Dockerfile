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
RUN dpkg -i libcudnn7-doc_7.5.1.10-1+cuda10.0_amd64.deb  && \
    rm libcudnn7-doc_7.5.1.10-1+cuda10.0_amd64.deb

RUN wget http://118.31.19.101:8080/software/amba/Ambarella_Toolchain_CNNGen_Ubuntu-18.04.tar.gz
RUN tar -zxvf Ambarella_Toolchain_CNNGen_Ubuntu-18.04.tar.gz -C ./ 
RUN ls -a
#RUN cd Ubuntu-18.04/ && \
#    ./ubuntuToolChain-2.1.7-20190815.ubuntu-18.04

# RUN wget http://118.31.19.101:8080/software/amba/caffe_ubuntu18.04.zip
# RUN unzip caffe_ubuntu18.04.zip
# RUN add-apt-repository --yes ppa:timsc/opencv-3.4
# RUN apt-get update
# RUN apt-get install -y build-essential cmake git pkg-config libprotobuf-dev libleveldb-dev libsnappy-dev libhdf5-serial-dev protobuf-compiler libatlas-base-dev libboost-all-dev libgflags-dev libgoogle-glog-dev liblmdb-dev python3-dev python3-numpy python3-scipy libopencv-dev libcv-dev python3-skimage libopenblas-dev

RUN mkdir /easy/

WORKDIR /easy
