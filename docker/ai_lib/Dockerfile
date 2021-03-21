FROM vitah/easy_base:1.0.0

# caffe所需依赖
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata && \
    apt-get install -y libleveldb-dev libsnappy-dev libhdf5-serial-dev \
    liblmdb-dev python3-scipy libopenblas-dev python3-skimage

# opencv依赖
RUN apt-get purge -y libopencv*
RUN apt-get install -y libgtk2.0-dev libavcodec-dev libavformat-dev libswscale-dev
# 处理图像所需的包
RUN apt-get install -y python-dev python-numpy python3-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff5-dev libjasper-dev libdc1394-22-dev
RUN apt-get install -y libavcodec-dev libavformat-dev libswscale-dev libv4l-dev liblapacke-dev
# 处理视频所需的包
RUN apt-get install -y libxvidcore-dev libx264-dev
# 优化opencv功能
RUN apt-get install -y libatlas-base-dev gfortran libeigen3-dev
RUN apt-get install -y ffmpeg

RUN echo "\n    Begin install OpenCV...\n" && \
    mkdir opencv && \
    cd /opencv && \
    curl -o opencv.zip http://118.31.19.101:8080/software/utility/opencv-3.4.6.zip  && \
    curl -o opencv_contrib.zip http://118.31.19.101:8080/software/utility/opencv_contrib-3.4.6.zip && \
    unzip opencv.zip && \
    unzip opencv_contrib.zip && \
    mv opencv-3.4.6 opencv && \
    mv opencv_contrib-3.4.6 opencv_contrib

RUN cd /opencv/opencv && \
    mkdir build && \
    cd build && \
    cmake \
    -D CMAKE_BUILD_TYPE=Release \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules/ \
    -D BUILD_EXAMPLES=ON \
    -D BUILD_opencv_java=OFF \
    -D BUILD_opencv_python2=OFF \
    -D BUILD_opencv_python3=OFF \
    -D BUILD_NEW_PYTHON_SUPPORT=OFF \
    -D ENABLE_PRECOMPILED_HEADERS=OFF \
    -D WITH_V4L=ON \
    -D WITH_CUDA=ON \
    -D WITH_TBB=ON \
    -D WITH_EIGEN=ON \
    # -D WITH_QT=ON \
    -D WITH_OPENCL=OFF \
    -D WITH_OPENGL=ON \
    -D WITH_OPENCL_SVM=OFF \
    -D WITH_OPENCLAMDFFT=OFF \
    -D WITH_OPENCLAMDBLAS=OFF \
    -D WITH_CUBLAS=ON \
    -D WITH_NVCUVID=ON \
    -D CUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda-10.0 \
    -D CUDA_ARCH_BIN=7.5 \
    -D CUDA_ARCH_PTX="" \
    -D INSTALL_C_EXAMPLES=ON .. && \
    make -j8 && \
    sudo make install

RUN echo '/usr/local/lib' | sudo tee -a /etc/ld.so.conf.d/opencv.conf && \
    sudo ldconfig && \
    printf "#OpenCV\nPKG_CONFIG_PATH=\$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig\nexport PKG_CONFIG_PATH\n">>/etc/bash.bashrc && \
    /bin/bash -c "source /etc/bash.bashrc" && \
    pkg-config --modversion opencv && \
    rm -rf /opencv /opencv_contrib /opencv.zip /opencv_contrib.zip

# caffe安装
RUN pip3 install -i https://mirrors.aliyun.com/pypi/simple numpy==1.16.6 && \
    pip3 install -i https://mirrors.aliyun.com/pypi/simple scikit-image==0.17.2 && \
    pip3 install -i https://mirrors.aliyun.com/pypi/simple python-dateutil==2.7.3
RUN echo "\n    Begin install caffe..." && \
    cd /opt && \
    curl -o caffe.zip http://118.31.19.101:8080/software/amba/docker_caffe.zip && \
    unzip caffe.zip && \
    cd /opt/caffe/python && \
    pip3 install -i https://mirrors.aliyun.com/pypi/simple -r requirements.txt && \
    cd /opt/caffe && \
    make all && \
    make pycaffe && \
    echo "export PYTHONPATH=/opt/caffe/python:\$PYTHONPATH">>/etc/bash.bashrc && \
    /bin/bash -c "source /etc/bash.bashrc" && \
    rm -rf /opt/caffe.zip && \
    echo "\n    Install caffe success"

# amba CNN安装
RUN pip3 install -i https://mirrors.aliyun.com/pypi/simple onnx==1.5 && \
    pip3 install -i https://mirrors.aliyun.com/pypi/simple numpy==1.16.6 && \
    pip3 install -i https://mirrors.aliyun.com/pypi/simple scipy==1.5.2 && \
    pip3 install -i https://mirrors.aliyun.com/pypi/simple scikit-image
RUN echo "\n    Begin install Ambarella...\n" && \
    mkdir amba && \
    cd /amba && \
    curl -O http://118.31.19.101:8080/software/amba/Ambarella_Toolchain_CNNGen_Ubuntu-18.04.zip && \
    unzip Ambarella_Toolchain_CNNGen_Ubuntu-18.04.zip && \
    cd /amba/Ubuntu-18.04/ && \
    ./ubuntuToolChain-2.1.7-20190815.ubuntu-18.04 && \
    rm -rf /amba && \
    echo "\n    Install Ambarella success\n"

# 安装PyTorch
RUN echo "\n    Begin install PyTorch..." && \
    pip3 uninstall torch && \
    curl -O http://118.31.19.101:8080/software/easyai/torch-1.0.1-cp36-cp36m-linux_x86_64.whl && \
    pip3 install torch-1.0.1-cp36-cp36m-linux_x86_64.whl && \
    rm torch-1.0.1-cp36-cp36m-linux_x86_64.whl && \
    echo "\n    Install PyTorch success\n"