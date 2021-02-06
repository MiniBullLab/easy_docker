FROM nvidia/cuda:10.0-devel-ubuntu18.04
ENV LANG C.UTF-8

RUN rm /etc/apt/sources.list.d/cuda.list && rm /etc/apt/sources.list.d/nvidia-ml.list

RUN add-apt-repository "deb http://security.ubuntu.com/ubuntu xenial-security main" && \
    # 系统所需依赖更新
    apt-get update && apt-get install -y software-properties-common && \
    apt-get update && \
    apt-get install -y git wget sudo vim unzip curl axel gcc g++ \
    libsm6 libxext6 libxrender-dev libglib2.0-0 python3-pip && \
    pip3 install install -i https://mirrors.aliyun.com/pypi/simple --upgrade pip

RUN apt-get install -y autoconf automake libtool pkg-config \
    build-essential libasio-dev libtinyxml2-dev libncurses5-dev libboost-all-dev

# 安装Cmake
RUN apt-get install -y libssl-dev && \
    apt-get remove -y cmake


# opencv依赖
RUN apt-get purge -y libopencv* && \
    apt-get install -y libgtk2.0-dev libavcodec-dev libavformat-dev libswscale-dev

# 处理图像所需的包
RUN apt-get install -y python-dev python-numpy python3-numpy \
    libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff5-dev libjasper-dev libdc1394-22-dev && \
    apt-get install -y libavcodec-dev libavformat-dev libswscale-dev libv4l-dev liblapacke-dev && \
    # 处理视频所需的包
    apt-get install -y libxvidcore-dev libx264-dev && \
    # 优化opencv功能
    apt-get install -y libatlas-base-dev gfortran libeigen3-dev ffmpeg

# caffe所需依赖
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata && \
    apt-get install -y libleveldb-dev libsnappy-dev libhdf5-serial-dev \
    liblmdb-dev python3-scipy libopenblas-dev python3-skimage

RUN apt-get install -y libglu1-mesa-dev freeglut3-dev mesa-common-dev libgl1-mesa-dev

# Qt5安装
RUN apt-get install -y libfontconfig libdbus-1-3 libx11-6 libx11-xcb1 libglib2.0-0

# 安装VTK
RUN apt-get purge -y libvtk* && \
    apt-get install -y libx11-dev libxext-dev libxtst-dev libxrender-dev libxmu-dev libxmuu-dev

# 安装PCL
RUN apt-get install -y libglew-dev libeigen3-dev libflann-dev libboost-dev \ 
    mpi-default-dev openmpi-bin openmpi-common libopenni-dev libopenni2-dev \
    libsm-dev uuid-dev libflann-dev libusb-1.0-0-dev libusb-dev libudev-dev libqhull* 

RUN echo "export PATH=/usr/local/cuda/bin:\$PATH">>/etc/bash.bashrc && \
    echo "export LD_LIBRARY_PATH=/usr/local/cuda/lib64:\$LD_LIBRARY_PATH">>/etc/bash.bashrc && \
    /bin/bash -c "source /etc/bash.bashrc"

RUN mkdir /easy_data
WORKDIR /easy_data
