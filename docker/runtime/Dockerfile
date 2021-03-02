FROM vitah/easy_lib:1.0.0

# 安装easy_ai
RUN echo "\n    Begin install easy_ai..." && \
    curl -O http://118.31.19.101:8080/software/easyai/easyai-0.3-py2.py3-none-any.whl  \
    -O http://118.31.19.101:8080/software/easyai/easy_converter-0.2-py2.py3-none-any.whl  \
    -O http://118.31.19.101:8080/software/easyai/easy_tools-0.2-py2.py3-none-any.whl && \ 
    pip3 install -i https://mirrors.aliyun.com/pypi/simple easyai-0.3-py2.py3-none-any.whl && \
    pip3 install -i https://mirrors.aliyun.com/pypi/simple easy_converter-0.2-py2.py3-none-any.whl && \
    pip3 install -i https://mirrors.aliyun.com/pypi/simple easy_tools-0.2-py2.py3-none-any.whl && \
    rm easyai-0.3-py2.py3-none-any.whl && \
    rm easy_converter-0.2-py2.py3-none-any.whl && \
    rm easy_tools-0.2-py2.py3-none-any.whl && \
    echo "export PYTHONPATH=/easy/easy_ai:\$PYTHONPATH">>/etc/bash.bashrc && \
    /bin/bash -c "source /etc/bash.bashrc" && \
    echo "\n    Install easy_ai success\n"

RUN chmod +x /usr/local/lib/python3.6/dist-packages/easy_tools/train_scripts/* && \
    echo "export PATH=/usr/local/lib/python3.6/dist-packages/easy_tools/train_scripts:\$PATH">>/etc/bash.bashrc && \
    /bin/bash -c "source /etc/bash.bashrc"

RUN curl -o senseshield.deb http://118.31.19.101:8080/software/dongle/senseshield-2.3.0.45988-x86_64.deb && \
    dpkg -i senseshield.deb && \
    rm senseshield.deb

RUN mkdir /easy_data
WORKDIR /easy_data