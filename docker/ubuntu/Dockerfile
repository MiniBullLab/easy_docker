FROM nvidia/cuda:10.0-devel-ubuntu18.04

RUN apt update && \
    apt install -y git && \
    apt  install -y wget && \
    apt  install -y cmake && \
    apt install -y sudo && \
    apt install -y libsm6 libxext6 libxrender-dev libglib2.0-0 && \
    apt install -y software-properties-common && \
    apt install -y unzip && \
    apt install -y vim && \
    apt install -y python3-pip && \
    pip3 install --upgrade pip 

RUN wget http://118.31.19.101:8080/software/gpu/libcudnn7_7.5.1.10-1%2Bcuda10.0_amd64.deb
RUN dpkg -i libcudnn7_7.5.1.10-1+cuda10.0_amd64.deb 

RUN wget http://118.31.19.101:8080/software/gpu/libcudnn7-dev_7.5.1.10-1%2Bcuda10.0_amd64.deb 
RUN dpkg -i libcudnn7-dev_7.5.1.10-1+cuda10.0_amd64.deb

RUN wget http://118.31.19.101:8080/software/gpu/libcudnn7-doc_7.5.1.10-1%2Bcuda10.0_amd64.deb
RUN dpkg -i libcudnn7-doc_7.5.1.10-1+cuda10.0_amd64.deb  

RUN wget http://118.31.19.101:8080/software/amba/caffe_ubuntu18.04.zip
RUN  unzip caffe_ubuntu18.04.zip

RUN mkdir /easy/

WORKDIR /easy
