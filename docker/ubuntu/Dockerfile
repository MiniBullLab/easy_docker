ARG UBUNTU_VERSION=latest
FROM ubuntu:${UBUNTU_VERSION}

RUN apt-get update && \
    apt-get install sudo && \
    sudo apt update && \
    sudo apt -y upgrade && \
    apt-get -y install python3 && \
    apt-get -y install git && \
    apt-get -y install vim

RUN python3 --version


RUN mkdir /easy
WORKDIR /easy