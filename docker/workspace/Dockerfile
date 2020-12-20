FROM nvidia/cuda:10.0-devel-ubuntu18.04

RUN rm /etc/apt/sources.list.d/cuda.list && rm /etc/apt/sources.list.d/nvidia-ml.list

# 系统所需依赖更新
RUN apt-get update && apt-get install -y software-properties-common && \
    apt-get update && \
    apt-get install -y git wget sudo vim unzip curl axel \
    libsm6 libxext6 libxrender-dev libglib2.0-0 python3-pip && \
    pip3 install install -i https://mirrors.aliyun.com/pypi/simple --upgrade pip

RUN apt-get install -y libasio-dev libtinyxml2-dev libncurses5-dev autoconf automake libtool

# 安装Cmake
RUN apt-get install -y libssl-dev && \
    apt-get remove -y cmake && \
    curl -L -O https://github.com/Kitware/CMake/archive/v3.14.0.tar.gz && \
    tar -vxf v3.14.0.tar.gz && \
    cd CMake-3.14.0/ && \
    ./bootstrap && \
    make && \
    sudo make install && \
    cmake --version

RUN add-apt-repository "deb http://security.ubuntu.com/ubuntu xenial-security main" && \
    apt update

# opencv依赖
RUN apt-get install build-essential
RUN apt-get install -y libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev
# 处理图像所需的包
RUN apt-get install -y python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff5-dev libjasper-dev libdc1394-22-dev         
RUN apt-get install -y libavcodec-dev libavformat-dev libswscale-dev libv4l-dev liblapacke-dev
# 处理视频所需的包
RUN apt-get install -y libxvidcore-dev libx264-dev
# 优化opencv功能
RUN apt-get install -y libatlas-base-dev gfortran          
RUN apt-get install -y ffmpeg
RUN echo "\n    Begin install OpenCV...\n" && \
    mkdir opencv && \
    cd /opencv && \
    curl -o opencv.zip http://118.31.19.101:8080/software/utility/opencv-3.4.6.zip  && \
    curl -L -o opencv_contrib.zip http://118.31.19.101:8080/software/utility/opencv_contrib-3.4.6.zip
RUN unzip opencv.zip && \
    unzip opencv_contrib.zip && \
    mv opencv-3.4.6 opencv && \
    mv opencv_contrib-3.4.6 opencv_contrib && \
    ls

RUN cd opencv && \
    mkdir build && \
    cd build && \
    cmake \
    -D CMAKE_BUILD_TYPE=Release \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules/ \
    -D CUDA_CUDA_LIBRARY=/usr/local/cuda/lib64/stubs/libcuda.so \
    -D CUDA_ARCH_BIN=7.5 \
    -D CUDA_ARCH_PTX="" \
    -D WITH_CUDA=ON \
    -D WITH_TBB=ON \
    -D BUILD_NEW_PYTHON_SUPPORT=OFF \
    -D WITH_V4L=ON \
    -D INSTALL_C_EXAMPLES=ON \
    -D BUILD_EXAMPLES=ON \
    # -D WITH_QT=ON \ 
    -D WITH_OPENGL=ON \
    -D ENABLE_FAST_MATH=1 \
    -D CUDA_FAST_MATH=1 \
    -D WITH_CUBLAS=1 \
    -D WITH_NVCUVID=ON \
    -D BUILD_opencv_cudacodec=OFF .. && \
    make -j && \
    sudo make install
RUN pkg-config --modversion opencv

# RUN curl -L -O https://github.com/protocolbuffers/protobuf/archive/v3.3.0.zip 
# RUN unzip v3.3.0.zip 
# RUN cd protobuf-3.3.0/ && \
#     ls && \
#     ./autogen.sh && \
#     ./configure && \
#     make && \ 
#     make check && \
#     sudo make install && \
#     sudo ldconfig

# RUN curl -L -O https://github.com/google/googletest/archive/release-1.10.0.tar.gz
# RUN tar -vxf release-1.10.0.tar.gz
# RUN ls
# RUN cd googletest-release-1.10.0 && \
#     mkdir google_test_build && \
#     cd google_test_build/ && \
#     cmake /googletest-release-1.10.0/ 
# RUN cd googletest-release-1.10.0 && \
#     ls && \
#     cd google_test_build/ && \
#     make && \
#     sudo make install



# # caffe所需依赖
# RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata && \
#     apt-get install -y build-essential pkg-config libprotobuf-dev \
#     libleveldb-dev libsnappy-dev libhdf5-serial-dev protobuf-compiler \
#     libatlas-base-dev libboost-all-dev libgflags-dev libgoogle-glog-dev \
#     liblmdb-dev libcv-dev python3-dev python3-numpy python3-scipy \
#     libopenblas-dev libopencv-dev python3-skimage

# # cudnn安装
# RUN  echo "\n    Begin install cudnn..." && \
#     dpkg --purge libcudnn7-doc && \
#     dpkg --purge libcudnn7-dev && \
#     dpkg --purge libcudnn7 && \
#     curl -o libcudnn.deb http://118.31.19.101:8080/software/gpu/libcudnn7_7.5.1.10-1+cuda10.0_amd64.deb  \ 
#     -o libcudnn-dev.deb http://118.31.19.101:8080/software/gpu/libcudnn7-dev_7.5.1.10-1+cuda10.0_amd64.deb \
#     -o libcudnn-doc.deb http://118.31.19.101:8080/software/gpu/libcudnn7-doc_7.5.1.10-1+cuda10.0_amd64.deb && \
#     dpkg -i libcudnn.deb && \
#     dpkg -i libcudnn-dev.deb && \
#     dpkg -i libcudnn-doc.deb && \
#     rm libcudnn.deb libcudnn-dev.deb libcudnn-doc.deb && \
#     echo "\n    Install cudnn success\n"

# RUN echo "export PATH=/usr/local/cuda/bin:\$PATH">>/etc/bash.bashrc && \
#     echo "export LD_LIBRARY_PATH=/usr/local/cuda/lib64:\$LD_LIBRARY_PATH">>/etc/bash.bashrc && \
#     /bin/bash -c "source /etc/bash.bashrc"

# # caffe安装
# RUN pip3 install -i https://mirrors.aliyun.com/pypi/simple numpy==1.16.6 && \
#     pip3 install -i https://mirrors.aliyun.com/pypi/simple scikit-image==0.17.2 && \
#     pip3 install -i https://mirrors.aliyun.com/pypi/simple python-dateutil==2.7.3
# RUN echo "\n    Begin install caffe..." && \
#     cd /opt && \
#     curl -o caffe.zip http://118.31.19.101:8080/software/amba/caffe_ubuntu18.04.zip && \
#     unzip caffe.zip && \
#     cd /opt/caffe/python && \
#     pip3 install -i https://mirrors.aliyun.com/pypi/simple -r requirements.txt && \
#     cd /opt/caffe && \
#     make all && \
#     make pycaffe && \
#     echo "export PYTHONPATH=/opt/caffe/python:\$PYTHONPATH">>/etc/bash.bashrc && \
#     /bin/bash -c "source /etc/bash.bashrc" && \
#     rm -rf /opt/caffe.zip && \
#     echo "\n    Install caffe success"

# # amba安装
# RUN pip3 install -i https://mirrors.aliyun.com/pypi/simple onnx==1.5 && \
#     pip3 install -i https://mirrors.aliyun.com/pypi/simple numpy==1.16.6 && \
#     pip3 install -i https://mirrors.aliyun.com/pypi/simple scipy==1.5.2 && \
#     pip3 install -i https://mirrors.aliyun.com/pypi/simple scikit-image
# RUN echo "\n    Begin install Ambarella...\n" && \
#     mkdir amba && \
#     cd /amba && \
#     curl -O http://118.31.19.101:8080/software/amba/Ambarella_Toolchain_CNNGen_Ubuntu-18.04.zip && \
#     unzip Ambarella_Toolchain_CNNGen_Ubuntu-18.04.zip && \
#     cd /amba/Ubuntu-18.04/ && \
#     ./ubuntuToolChain-2.1.7-20190815.ubuntu-18.04 && \
#     rm -rf /amba && \
#     echo "\n    Install Ambarella success\n"

# # 安装PyTorch
# RUN echo "\n    Begin install PyTorch..." && \
#     pip3 uninstall torch && \
#     curl -O http://118.31.19.101:8080/software/easyai/torch-1.0.1-cp36-cp36m-linux_x86_64.whl && \
#     pip3 install torch-1.0.1-cp36-cp36m-linux_x86_64.whl && \
#     rm torch-1.0.1-cp36-cp36m-linux_x86_64.whl && \
#     echo "\n    Install PyTorch success\n"

# # 安装easy_ai
# RUN echo "\n    Begin install easy_ai..." && \
#     curl -O http://118.31.19.101:8080/software/easyai/easyai-0.3-py2.py3-none-any.whl  \
#     -O http://118.31.19.101:8080/software/easyai/easy_converter-0.2-py2.py3-none-any.whl  \
#     -O http://118.31.19.101:8080/software/easyai/easy_tools-0.2-py2.py3-none-any.whl && \ 
#     pip3 install -i https://mirrors.aliyun.com/pypi/simple easyai-0.3-py2.py3-none-any.whl && \
#     pip3 install -i https://mirrors.aliyun.com/pypi/simple easy_converter-0.2-py2.py3-none-any.whl && \
#     pip3 install -i https://mirrors.aliyun.com/pypi/simple easy_tools-0.2-py2.py3-none-any.whl && \
#     rm easyai-0.3-py2.py3-none-any.whl && \
#     rm easy_converter-0.2-py2.py3-none-any.whl && \
#     rm easy_tools-0.2-py2.py3-none-any.whl && \
#     echo "export PYTHONPATH=/easy/easy_ai:\$PYTHONPATH">>/etc/bash.bashrc && \
#     /bin/bash -c "source /etc/bash.bashrc" && \
#     echo "\n    Install easy_ai success\n"

# RUN echo "export PATH=/usr/local/lib/python3.6/dist-packages/easy_tools/train_scripts:\$PATH">>/etc/bash.bashrc && \
#     /bin/bash -c "source /etc/bash.bashrc"

RUN mkdir /easy
WORKDIR /easy
