FROM nvidia/cuda:10.0-devel-ubuntu18.04

RUN rm /etc/apt/sources.list.d/cuda.list && rm /etc/apt/sources.list.d/nvidia-ml.list

COPY add_user.sh /scripts/

RUN cat /etc/os-release

RUN mkdir /easy_ai/
WORKDIR /easy_ai
