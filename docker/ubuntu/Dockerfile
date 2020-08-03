ARG UBUNTU_VERSION=latest
FROM ubuntu:${UBUNTU_VERSION}

RUN apt-get update && \
    apt-get install sudo && \
    sudo apt update && \
    sudo apt -y upgrade && \
    apt-get -y install python3

RUN python3 --version


RUN mkdir /easy
WORKDIR /easy