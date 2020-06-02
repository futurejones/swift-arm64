# Ubuntu xenial 16.04
# For Jenkins pipeline
FROM ubuntu:16.04

RUN groupadd -g 998 build-user && \
    useradd -m -r -u 998 -g build-user build-user

ENV DEBIAN_FRONTEND="noninteractive"

RUN apt-get update && apt-get -y install \
    wget \
    build-essential \
    clang \
    clang-6.0 \
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

RUN update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-3.8 100
RUN update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-6.0 1000
RUN update-alternatives --install /usr/bin/clang clang /usr/bin/clang-3.8 100
RUN update-alternatives --install /usr/bin/clang clang /usr/bin/clang-6.0 1000

RUN git clone https://github.com/Kitware/CMake.git && cd CMake && git checkout v3.16.6 && ./bootstrap --prefix=/usr && make && make install

USER build-user

WORKDIR /home/build-user
