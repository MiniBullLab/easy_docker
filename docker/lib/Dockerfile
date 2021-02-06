FROM vitah/easy_base:1.0

# 安装Cmake
RUN apt-get install -y libssl-dev && \
    apt-get remove -y cmake && \
    curl -L -O https://github.com/Kitware/CMake/archive/v3.14.0.tar.gz && \
    tar -vxf v3.14.0.tar.gz && \
    cd CMake-3.14.0/ && \
    ./bootstrap && \
    make && \
    sudo make install && \
    cmake --version && \
    rm -rf /v3.14.0.tar.gz  /CMake-3.14.0

# 安装protobuf
RUN curl -L -O https://github.com/protocolbuffers/protobuf/archive/v3.3.0.zip && \
    unzip v3.3.0.zip && \
    cd protobuf-3.3.0/ && \
    ./autogen.sh && \
    ./configure --prefix=/usr/local && \
    make && \ 
    make check && \
    sudo make install && \
    echo "export LD_LIBRARY_PATH=/usr/local/lib/:\$LD_LIBRARY_PATH">>/etc/bash.bashrc && \
    /bin/bash -c "source /etc/bash.bashrc" && \
    sudo ldconfig && \
    pkg-config --cflags --libs protobuf && \
    rm -rf /v3.3.0.zip /protobuf-3.3.0

# 安装googletest
RUN curl -L -O https://github.com/google/googletest/archive/release-1.10.0.tar.gz && \
    tar -vxf release-1.10.0.tar.gz && \
    cd googletest-release-1.10.0 && \
    mkdir google_test_build && \
    cd google_test_build/ && \
    cmake -DCMAKE_INSTALL_PREFIX=/usr/local -DBUILD_SHARED_LIBS=ON -G "Unix Makefiles" ../ && \
    make -j8 && \
    sudo make install && \
    sudo ldconfig && \
    rm -rf /release-1.10.0.tar.gz /googletest-release-1.10.0

# 安装gflags
RUN curl -L -O  https://github.com/gflags/gflags/archive/v2.2.0.tar.gz && \
    tar -vxf v2.2.0.tar.gz && \
    cd gflags-2.2.0 && \
    mkdir gflags_build && \
    cd gflags_build/ && \
    cmake -DCMAKE_INSTALL_PREFIX=/usr/local -DBUILD_SHARED_LIBS=ON  -DGFLAGS_NAMESPACE=gflags ../ && \
    make -j8 && \
    sudo make install && \
    sudo ldconfig && \
    rm -rf /v2.2.0.tar.gz /gflags-2.2.0

# 安装glog
RUN curl -L -O https://github.com/google/glog/archive/v0.3.5.tar.gz && \
    tar -vxf v0.3.5.tar.gz && \
    cd glog-0.3.5 && \
    ./configure && \
    make -j8 && \
    sudo make install && \
    sudo ldconfig && \
    rm -rf /v0.3.5.tar.gz /glog-0.3.5

# 安装poco
RUN curl -L -O https://github.com/pocoproject/poco/archive/poco-1.8.0-release.tar.gz && \
    tar -vxf poco-1.8.0-release.tar.gz && \
    cd poco-poco-1.8.0-release && \
    mkdir cmake-build && \
    cd cmake-build && \
    cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local && \
    cmake --build . --config Releases && \
    sudo cmake --build . --target install && \
    sudo ldconfig && \
    rm -rf /poco-1.8.0-release.tar.gz /poco-poco-1.8.0-release 

# 安装Fast-CDR
RUN curl -L -O  http://118.31.19.101:8080/software/utility/Fast-CDR.zip && \
    unzip Fast-CDR.zip && \
    cd Fast-CDR && \
    mkdir CDR_build && \
    cd CDR_build/ && \
    cmake -DCMAKE_INSTALL_PREFIX=/usr/local -DBUILD_SHARED_LIBS=ON ../ && \
    make -j8 && \
    sudo make install && \
    sudo ldconfig && \
    rm -rf /Fast-CDR.zip  /Fast-CDR 

# 安装Fast-RTPS
RUN curl -L -O  http://118.31.19.101:8080/software/utility/Fast-RTPS.zip && \
    unzip Fast-RTPS.zip && \
    cd Fast-RTPS && \
    mkdir RTPS_build && \
    cd RTPS_build/ && \
    cmake -DCMAKE_INSTALL_PREFIX=/usr/local -DBUILD_SHARED_LIBS=ON ../ && \
    make -j8 && \
    sudo make install && \
    sudo ldconfig && \
    rm -rf F/ast-RTPS.zip /Fast-RTPS 

# cudnn安装
RUN  echo "\n    Begin install cudnn..." && \
    dpkg --purge libcudnn7-doc && \
    dpkg --purge libcudnn7-dev && \
    dpkg --purge libcudnn7 && \
    curl -o libcudnn.deb http://118.31.19.101:8080/software/gpu/libcudnn7_7.5.1.10-1+cuda10.0_amd64.deb  \ 
    -o libcudnn-dev.deb http://118.31.19.101:8080/software/gpu/libcudnn7-dev_7.5.1.10-1+cuda10.0_amd64.deb \
    -o libcudnn-doc.deb http://118.31.19.101:8080/software/gpu/libcudnn7-doc_7.5.1.10-1+cuda10.0_amd64.deb && \
    dpkg -i libcudnn.deb && \
    dpkg -i libcudnn-dev.deb && \
    dpkg -i libcudnn-doc.deb && \
    rm libcudnn.deb libcudnn-dev.deb libcudnn-doc.deb && \
    echo "\n    Install cudnn success\n"

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
    pip3 install -i https://mirrors.aliyun.com/pypi/simple python-dateutil==2.7.3 && \
    echo "\n    Begin install caffe..." && \
    cd /opt && \
    curl -o caffe.zip http://118.31.19.101:8080/software/amba/caffe_ubuntu18.04.zip && \
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

RUN curl -O http://118.31.19.101:8080/software/utility/qt-everywhere-src-5.12.0.tar.xz && \
    tar -xvJf qt-everywhere-src-5.12.0.tar.xz && \
    cd qt-everywhere-src-5.12.0 && \
    ./configure -confirm-license \
    -prefix /opt/qt512 -opensource -release -shared -glib -fontconfig -qt-zlib -qt-libpng -qt-libjpeg \
    -qt-xcb -opengl desktop -make libs -nomake tools -nomake examples -nomake tests -skip qtmacextras \
    -skip qtandroidextras && \
    make -j8 && \
    sudo make install && \
    rm -rf /qt-everywhere-src-5.12.0 /qt-everywhere-src-5.12.0.tar.xz
RUN echo "export PATH=/opt/qt512/bin:\$PATH">>/etc/bash.bashrc && \
    echo "export LD_LIBRARY_PATH=/opt/qt512/lib:\$LD_LIBRARY_PATH">>/etc/bash.bashrc && \
    echo "export QMAKESPEC=/opt/qt512/mkspecs/linux-g++" >> /etc/bash.bashrc && \
    /bin/bash -c "source /etc/bash.bashrc"

# 安装VTK
RUN curl -L -O  http://118.31.19.101:8080/software/utility/VTK-8.1.2.tar.gz && \
    curl -L -O  http://118.31.19.101:8080/software/utility/VTKData-8.1.2.tar.gz && \
    tar -xvzf VTK-8.1.2.tar.gz && \
    tar -xvzf VTKData-8.1.2.tar.gz && \
    cd VTK-8.1.2 && \
    mkdir build && \
    cd build && \
    cmake -DCMAKE_INSTALL_PREFIX=/usr/local \
    -DVTK_QT_VERSION:STRING=5 \
    -DQT_QMAKE_EXECUTABLE:PATH=/opt/qt512/bin/qmake \
    -DVTK_Group_Qt:BOOL=ON \
    -DCMAKE_PREFIX_PATH:PATH=/opt/qt512/lib/cmake  \
    -DCMAKE_BUILD_TYPE=RELEASE \
    -DBUILD_SHARED_LIBS:BOOL=ON .. && \
    make -j8 && \
    sudo make install && \
    sudo ldconfig && \
    rm -rf /VTK-8.1.2 /VTK-8.1.2.tar.gz /VTKData-8.1.2.tar.gz
RUN mkdir /opt/qt512/plugins/designer && \
    cp /usr/local/plugins/designer/libQVTKWidgetPlugin.so /opt/qt512/plugins/designer/

# 安装PCL
RUN curl -L -O  http://118.31.19.101:8080/software/utility/pcl-pcl-1.9.0.tar.gz && \
    tar -xvzf pcl-pcl-1.9.0.tar.gz && \
    cd pcl-pcl-1.9.0 && \
    mkdir build && \
    cd build && \
    cmake -DCMAKE_INSTALL_PREFIX=/usr/local \
    -DCMAKE_BUILD_TYPE=None \
    -DBuild_visualization=ON \
    -DBUILD_GPU=ON -DBUILD_apps=ON -DBUILD_examples=ON \
    -D WITH_QT=ON \
    -D WITH_CUDA=ON \
    -D PCL_SHARED_LIBS=ON \
    -D PCL_QT_VERSION=5 \
    -D CUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda-10.0 \
    -D VTK_DIR=/usr/local/lib/cmake/vtk-8.1 .. && \
    make -j8 && \
    sudo make install && \
    sudo ldconfig && \
    rm -rf /pcl-pcl-1.9.0 /pcl-pcl-1.9.0.tar.gz

# amba安装
RUN pip3 install -i https://mirrors.aliyun.com/pypi/simple onnx==1.5 && \
    pip3 install -i https://mirrors.aliyun.com/pypi/simple numpy==1.16.6 && \
    pip3 install -i https://mirrors.aliyun.com/pypi/simple scipy==1.5.2 && \
    pip3 install -i https://mirrors.aliyun.com/pypi/simple scikit-image && \
    echo "\n    Begin install Ambarella...\n" && \
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

# 安装apex
RUN curl -O http://118.31.19.101:8080/software/gpu/apex.zip && \
    unzip apex.zip && \
    cd apex && \
    pip3 install -v --disable-pip-version-check --no-cache-dir --global-option="--cpp_ext" --global-option="--cuda_ext" ./ && \
    rm -rf /apex /apex.zip