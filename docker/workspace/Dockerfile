FROM ai_workspace_lib:latest

# 安装easy_ai依赖库
COPY ai_requirements.txt convert_requirements.txt tools_requirements.txt /scripts/
RUN pip3 install -i https://mirrors.aliyun.com/pypi/simple -r /scripts/ai_requirements.txt && \
    pip3 install -i https://mirrors.aliyun.com/pypi/simple -r /scripts/convert_requirements.txt && \
    pip3 install -i https://mirrors.aliyun.com/pypi/simple -r /scripts/tools_requirements.txt && \
    echo "export PYTHONPATH=/easy_ai/easy_ai:\$PYTHONPATH">>/etc/bash.bashrc && \
    /bin/bash -c "source /etc/bash.bashrc"

# 安装apex
RUN curl -O http://118.31.19.101:8080/software/gpu/apex.zip && \
    unzip apex.zip && \
    cd apex && \
    pip3 install -v --disable-pip-version-check --no-cache-dir --global-option="--cpp_ext" --global-option="--cuda_ext" ./ && \
    rm -rf /apex /apex.zip

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
