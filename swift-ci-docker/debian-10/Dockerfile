# Debian buster 10
# For Jenkins pipeline
FROM debian:10

RUN groupadd -g 998 build-user && \
    useradd -m -r -u 998 -g build-user build-user

ENV DEBIAN_FRONTEND="noninteractive"

RUN apt-get update

RUN apt-get -y install \
    wget \
    autoconf \
    build-essential \
    clang \
    git \
    icu-devtools \
    libbsd-dev \
    libblocksruntime-dev \
    libcurl4-openssl-dev \
    libedit-dev \
    libicu-dev \
    libncurses5-dev \
    libpython-dev \
    libssl-dev \
    libsqlite3-dev \
    libtool \
    libxml2-dev \
    libz-dev \
    make \
    ninja-build \
    patch \
    pkg-config \
    python \
    python-dev \
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
    uuid-dev \
    zip

RUN git clone https://github.com/Kitware/CMake.git && cd CMake && git checkout v3.16.6 && ./bootstrap --prefix=/usr && make && make install

USER build-user

WORKDIR /home/build-user
