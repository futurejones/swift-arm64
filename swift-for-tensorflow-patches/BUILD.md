## Build instructions for Swift for TensorFlow on Ubuntu 16.04

#### Development Dependencies Required
```sudo apt-get install git cmake ninja-build clang python uuid-dev libicu-dev icu-devtools libbsd-dev libedit-dev libxml2-dev libsqlite3-dev swig libpython-dev libncurses5-dev pkg-config libblocksruntime-dev libcurl4-openssl-dev systemtap-sdt-dev tzdata rsync```

#### Install Bazel Version 0.20.0
Add build-tools repository  
```curl -s https://packagecloud.io/install/repositories/swift-arm/build_tools/script.deb.sh | sudo bash```
Install Bazel  
```sudo apt-get install bazel=0.20.0```

#### Patches Required.
* https://github.com/futurejones/swift-arm64/raw/master/swift-for-tensorflow-patches/aarch64-new-master-VarArgs.patch
* https://github.com/futurejones/swift-arm64/raw/master/swift-for-tensorflow-patches/goldLinkerUnixToolChains.patch
* https://github.com/futurejones/swift-arm64/raw/master/swift-for-tensorflow-patches/tensorflow_build_preset.patch
* https://github.com/futurejones/swift-arm64/raw/master/swift-for-tensorflow-patches/fix-aws-s3.patch


#### Build Info
Create source directory  
```mkdir swift-source && cd swift-source```

Clone Swift repository  
```git clone https://github.com/apple/swift.git -b tensorflow```

Checkout tensorflow branch and supporting repositories  
```./swift/utils/update-checkout --clone --scheme tensorflow```

Apply patches to swift directory  
```
cd swift 
wget https://github.com/futurejones/swift-arm64/raw/master/swift-for-tensorflow-patches/aarch64-new-master-VarArgs.patch
git apply aarch64-new-master-VarArgs.patch

wget https://github.com/futurejones/swift-arm64/raw/master/swift-for-tensorflow-patches/tensorflow_build_preset.patch
git apply tensorflow_build_preset.patch

wget https://github.com/futurejones/swift-arm64/raw/master/swift-for-tensorflow-patches/goldLinkerUnixToolChains.patch
git apply goldLinkerUnixToolChains.patch

cd -
```

Apply patches to tensorflow directory  
```
cd tensorflow
wget https://github.com/futurejones/swift-arm64/raw/master/swift-for-tensorflow-patches/fix-aws-s3.patch
git apply fix-aws-s3.patch
cd -
```

Build Swift for TensorFlow  
```
./swift/utils/build-script --preset=buildbot_linux_1604_tensorflow install_destdir=/home/worksonarm_test/jenkins_slave/workspace/swift-tensorflow/install installable_package=/home/worksonarm_test/jenkins_slave/workspace/swift-tensorflow/install/swift-tensorflow-aarch64.tar.gz
```
#### Pre-built binary available here [swift-for-tensorflow-dev-2019-01-14](https://github.com/futurejones/swift-arm64/releases/tag/swift-for-tensorflow-dev-2019-01-14)
