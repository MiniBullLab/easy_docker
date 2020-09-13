FROM nvidia/cuda:10.0-devel-ubuntu18.04

RUN apt update && \
    apt install -y git && \
    apt  install -y wget && \
    apt  install -y cmake && \
    apt install -y sudo && \
    apt install -y python3-pip && \
    pip3 install scikit-learn

RUN mkdir /easy

WORKDIR /easy