# Ubuntu bionic 18.04
# For Jenkins pipeline
FROM ubuntu:18.04

RUN groupadd -g 998 build-user && \
    useradd -m -r -u 998 -g build-user build-user

ENV DEBIAN_FRONTEND="noninteractive"

RUN apt-get update

RUN apt-get -y install \
    wget \
    build-essential \
    clang \
    cmake \
    git \
    icu-devtools \
    libbsd-dev \
    libblocksruntime-dev \
    libcurl4-openssl-dev \
    libedit-dev \
    libicu-dev \
    libncurses5-dev \
    libpython-dev \
    libsqlite3-dev \
    libssl-dev \
    libxml2-dev \
    make \
    ninja-build \
    pkg-config \
    python \
    python-dev \
    python-six \
    python3 \
    python3-dev \
    python3-six \
    rsync \
    swig \
    systemtap-sdt-dev \
    tzdata \
    unzip \
    uuid-dev \
    zip

RUN git clone https://github.com/Kitware/CMake.git && cd CMake && git checkout v3.16.6 && ./bootstrap --prefix=/usr && make && make install

USER build-user

WORKDIR /home/build-user
