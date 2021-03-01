FROM vitah/easy_lib:1.0.0

# amba下位机编译环境安装
RUN apt-get install -y gnupg flex bison gperf \
    zlib1g-dev mtd-utils fakeroot genext2fs gawk subversion \
    unixodbc texinfo gcc-multilib g++-multilib autoconf libsqlite3-dev graphviz libc6-i386 libssl-dev
RUN echo "\n    Begin install Ambarella Toolchain...\n" && \
    mkdir amba && \
    cd /amba && \
    curl -O http://118.31.19.101:8080/software/amba/Ambarella_Toolchain_Linaro_2018.08.zip && \
    unzip Ambarella_Toolchain_Linaro_2018.08.zip && \
    cd Ambarella_Toolchain_Linaro_2018.08 && \
    chmod +x ubuntuToolChain-201808 && \
    ./ubuntuToolChain-201808 && \
    rm -rf /amba && \
    echo "\n    Install Ambarella Toolchain success\n"

# 安装easy_ai依赖库
COPY ai_requirements.txt convert_requirements.txt tools_requirements.txt /scripts/
RUN pip3 install -i https://mirrors.aliyun.com/pypi/simple -r /scripts/ai_requirements.txt && \
    pip3 install -i https://mirrors.aliyun.com/pypi/simple -r /scripts/convert_requirements.txt && \
    pip3 install -i https://mirrors.aliyun.com/pypi/simple -r /scripts/tools_requirements.txt && \
    echo "export PYTHONPATH=/easy_ai/easy_ai:\$PYTHONPATH">>/etc/bash.bashrc && \
    /bin/bash -c "source /etc/bash.bashrc"

# nvidia opengl
RUN curl -O http://118.31.19.101:8080/software/gpu/nvidia_opengl.zip && \
    unzip nvidia_opengl.zip && \
    cp nvidia_opengl/* /usr/lib/x86_64-linux-gnu/ && \
    cd /usr/lib/x86_64-linux-gnu/ && \
    rm libGLX_indirect.so.0 && \
    ln -s libGLX_nvidia.so.440.82 libGLX_indirect.so.0 && \
    rm -rf /nvidia_opengl.zip /nvidia_opengl

COPY add_user.sh /scripts/

RUN mkdir /easy_data
WORKDIR /easy_data
