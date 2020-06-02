# Ubuntu Focal 20.04
# For Jenkins pipeline
FROM ubuntu:20.04

RUN groupadd -g 998 build-user && \
    useradd -m -r -u 42 -g build-user build-user

ENV DEBIAN_FRONTEND="noninteractive"

RUN apt-get update

RUN apt-get -y install \
    wget \
    build-essential \
    clang \
    cmake \
    git \
    icu-devtools \
    libcurl4-openssl-dev \
    libedit-dev \
    libicu-dev \
    libncurses5-dev \
    libsqlite3-dev \
    libssl-dev \
    libxml2-dev \
    ninja-build \
    pkg-config \
    python2 \
    python2-dev \
    python-six \
    python3 \
    python3-dev \
    python3-distutils \
    python3-six \
    rsync \
    swig \
    systemtap-sdt-dev \
    tzdata \
    unzip \
    uuid-dev

RUN git clone https://github.com/Kitware/CMake.git && cd CMake && git checkout v3.16.6 && ./bootstrap --prefix=/usr && make && make install

RUN ln -s /usr/bin/python2 /usr/bin/python

USER build-user

WORKDIR /home/build-user
