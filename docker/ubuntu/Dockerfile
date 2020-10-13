FROM nvidia/cuda:10.0-devel-ubuntu18.04

RUN apt-get update 
RUN apt-get install -y git && \
    apt-get  install -y wget && \
    apt-get  install -y cmake && \
    apt-get install -y sudo && \ 
    apt-get install -y vim && \
    apt-get install -y unzip 
RUN apt-get install -y libsm6 libxext6 libxrender-dev libglib2.0-0 && \
    apt-get install -y software-properties-common && \
    apt-get install -y python3-pip && \
    pip3 install --upgrade pip 

RUN wget http://118.31.19.101:8080/software/gpu/libcudnn7_7.5.1.10-1%2Bcuda10.0_amd64.deb
RUN dpkg -i libcudnn7_7.5.1.10-1+cuda10.0_amd64.deb 

RUN wget http://118.31.19.101:8080/software/gpu/libcudnn7-dev_7.5.1.10-1%2Bcuda10.0_amd64.deb 
RUN dpkg -i libcudnn7-dev_7.5.1.10-1+cuda10.0_amd64.deb

RUN wget http://118.31.19.101:8080/software/gpu/libcudnn7-doc_7.5.1.10-1%2Bcuda10.0_amd64.deb
RUN dpkg -i libcudnn7-doc_7.5.1.10-1+cuda10.0_amd64.deb  

# RUN wget http://118.31.19.101:8080/software/amba/caffe_ubuntu18.04.zip
# RUN  unzip caffe_ubuntu18.04.zip

RUN mkdir /easy/

WORKDIR /easy
