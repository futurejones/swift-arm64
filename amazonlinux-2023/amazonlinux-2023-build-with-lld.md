# How to Build Swift for Amazon Linux 2023 using LLD Linker

## Install Swift build dependencies

```sh
sudo yum -y install \
 clang \
 cmake \
 curl-devel \
 gcc-c++ \
 git \
 glibc-static \
 libbsd-devel \
 libedit-devel \
 libicu-devel \
 libuuid-devel \
 libxml2-devel \
 lld \
 ncurses-devel \
 ninja-build \
 python3-pexpect \
 pkgconfig \
 procps-ng \
 python \
 python3-devel \
 python3-six \
 python3-psutil \
 python3-pkgconfig \
 python3-pip \
 rsync \
 sqlite-devel \
 swig \
 tzdata \
 unzip \
 uuid-devel \
 wget \
 which \
 zip
```

## Clone Swift

```sh
mkdir swift-source && cd swift-source
git clone https://github.com/apple/swift.git swift
```

## Clone Supporting Repositories

```
swift/utils/update-checkout --clone
```

## Checkout Swift Version

#### Branch

```
swift/utils/update-checkout --scheme release/5.9
```

#### Tag

```
swift/utils/update-checkout --tag swift-5.9.2-RELEASE
```

## Apply Patches

#### Replace "gold" with "lld" in the following files

1. https://github.com/apple/swift/blob/main/CMakeLists.txt#L959
2. https://github.com/apple/swift/blob/main/lib/Driver/UnixToolChains.cpp#L112
3. https://github.com/apple/swift-corelibs-foundation/blob/main/lib/target.py#L345
4. https://github.com/apple/swift-driver/blob/main/Sources/SwiftDriver/Jobs/GenericUnixToolchain%2BLinkerSupport.swift#L25

#### Modify buildbot preset

1. https://github.com/apple/swift/blob/main/utils/build-presets.ini#L809

   Add the following to **[preset: mixin_linux_installation]** after the line - `mixin_linux_install_components_with_clang`

   ```ini
   ####
   extra-cmake-options=
      -DLLVM_USE_LINKER=lld
      -DSWIFT_USE_LINKER=lld

   skip-early-swift-driver
   skip-early-swiftsyntax

   bootstrapping=off
   ####
   ```
**Patches** for Swift versions 5.8 and 5.9 are available here - [patches](https://github.com/futurejones/swift-arm64/tree/master/amazonlinux-2023/patches)

## Build Swift using Buildbot Preset

```
swift/utils/build-script --preset=buildbot_linux,no_assertions,no_test install_destdir=/tmp installable_package=/tmp/swift-5.9-amazonlinux2023.tar.gz
```

## Dependencies Needed for Swift Installation

```sh
dnf -y install \
binutils \
gcc \
git \
glibc-static \
gzip \
libbsd \
libcurl-devel \
libedit \
libicu \
libstdc++-static \
libuuid \
libxml2-devel \
sqlite \
tar \
tzdata \
unzip \
zip
```
