# How to Build Swift for Amazon Linux 2023 using LLD Linker

#### \*\*\* Updated for swift version 5.10 \*\*\*

## Creating a Swift Bootstrapped Build Environment

#### Install build dependencies

```sh
dnf install shadow-utils -y

dnf -y group install "development tools"

dnf -y install \
  curl-devel       \
  glibc-static     \
  libbsd-devel     \
  libedit-devel    \
  libicu-devel     \
  libuuid-devel    \
  libxml2-devel    \
  ncurses-devel    \
  pkgconfig        \
  procps-ng        \
  python           \
  python-devel     \
  python-six       \
  python3-devel    \
  python3-pexpect  \
  python3-pkgconfig \
  python3-psutil   \
  rsync            \
  sqlite-devel     \
  tzdata           \
  uuid-devel       \
  wget             \
  which
```

**\* **NOTE:** \***  
If you are not bootstrapping with an existing swift toolchain add `clang` and `lld` to the build dependencies.

#### Install swift 5.8.1 toolchain

```sh
mkdir -p /opt/swift/5.8.1
wget https://github.com/futurejones/swift-arm64/releases/download/amazon-linux-2023-dev/swiftlang-5.8.1-amazonlinux-2023-release-aarch64-01.tar.gz
tar -xzf swiftlang-5.8.1-amazonlinux-2023-release-aarch64-01.tar.gz --directory /opt/swift/5.8.1
rm -rf swiftlang-5.8.1-amazonlinux-2023-release-aarch64-01.tar.gz
chmod -R o+r /opt/swift/5.8.1/usr/lib/swift

PATH="/opt/swift/5.8.1/usr/bin:${PATH}"
```

### Clone Swift

```sh
mkdir swift-source && cd swift-source
git clone https://github.com/apple/swift.git swift
```

### Clone Supporting Repositories

```
swift/utils/update-checkout --clone --tag swift-5.10-RELEASE
```

### Apply Patches

#### patching swift

```sh
cd swift
wget https://raw.githubusercontent.com/futurejones/swift-arm64/master/amazonlinux-2023/patches/swift-5.10/72049-5.10.patch"
git apply 72049-5.10.patch
wget https://raw.githubusercontent.com/futurejones/swift-arm64/master/amazonlinux-2023/patches/swift-5.10/nostart-stop-gc-5.10.patch
git apply nostart-stop-gc-5.10.patch
cd -
```

#### patching swift-driver

```sh
cd swift-driver
wget https://github.com/apple/swift-driver/pull/1545.patch
git apply 1545.patch"
cd -
```

#### patching llvm-project

**\* **NOTE:** \***  
If you building on a `aarch64/arm64` system you will also need the following patch.

```sh
cd llvm-project
wget https://github.com/apple/llvm-project/pull/8228.patch
git apply 8228.patch
cd -
```

### Build Swift using Buildbot Preset

```
#
swift/utils/build-script --preset=buildbot_linux,no_assertions,no_test install_destdir=/home/$USER/install installable_package=/home/$USER/install/swift-5.10-amazonlinux2023.tar.gz
```

#### Modify buildbot preset for non-bootstrapped build

**\* **NOTE:** \***  
If you are not bootstrapping with an existing swift toolchain you will need to modify the buildbot preset.  
Buildbot presets are found in the `swift/utils/build-presets.ini` file.

Add the following to **[preset: mixin_linux_installation]** after the line - `mixin_linux_install_components_with_clang`

```ini
####

skip-early-swift-driver
skip-early-swiftsyntax

bootstrapping=off
####
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
