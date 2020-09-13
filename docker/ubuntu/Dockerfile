FROM nvidia/cuda:10.0-devel-ubuntu18.04

RUN apt update && \
    apt  install -y wget && \
    apt install -y sudo && \
    apt install -y python3-pip

RUN mkdir /easy

WORKDIR /easy