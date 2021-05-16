FROM nvidia/cuda:10.0-devel-ubuntu18.04 as cmake-builder

RUN apt-get update && \
    apt-get install -y curl sudo
RUN apt-get remove -y cmake && \
    apt-get install -y --no-install-recommends libssl-dev && \
    curl -L -O http://118.31.19.101:8080/software/utility/cmake-3.14.0.tar.gz && \
    tar -vxf cmake-3.14.0.tar.gz && \
    cd cmake-3.14.0/ && \
    ./bootstrap && \
    make && \
    sudo make install && \
    rm -rf /cmake-3.14.0.tar.gz  /cmake-3.14.0
RUN cmake --version

FROM nvidia/cuda:10.0-devel-ubuntu18.04
RUN apt-get remove -y cmake
RUN apt-get update && \
    apt-get install -y curl sudo
COPY --from=cmake-builder /usr/local/bin/cmake /usr/local/bin/
COPY --from=cmake-builder /usr/local/bin/cpack /usr/local/bin/
COPY --from=cmake-builder /usr/local/bin/ctest /usr/local/bin/
RUN cmake --version