# Fedora
# For Jenkins pipeline
FROM fedora:32

RUN groupadd -g 42 build-user && \
    useradd -m -r -u 42 -g build-user build-user

RUN yum -y update

RUN yum install -y \
    autoconf              \
    clang                 \
    git                   \
    libbsd-devel          \
    libcurl-devel         \
    libedit-devel         \
    libicu-devel          \
    libtool               \
    libuuid-devel         \
    libxml2-devel         \
    make                  \
    ncurses-devel         \
    ninja-build           \
    openssl-devel    \
    pcre-devel            \
    python2               \
    python2-devel         \
    python2-six           \
    python3               \
    python3-six           \
    python3-pexpect       \
    sqlite-devel          \
    swig                  \
    rsync                 \
    tar                   \
    which

RUN ln -s /usr/bin/python2 /usr/bin/python

RUN git clone https://github.com/Kitware/CMake.git && cd CMake && git checkout v3.16.6 && ./bootstrap --prefix=/usr && make && make install

USER build-user

WORKDIR /home/build-user
