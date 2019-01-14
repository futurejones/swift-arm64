## Build instructions for Swift for TensorFlow on Ubuntu 16.04

#### Patches Required.
* https://github.com/futurejones/swift-arm64/raw/master/swift-for-tensorflow-patches/aarch64-new-master-VarArgs.patch
* https://github.com/futurejones/swift-arm64/raw/master/swift-for-tensorflow-patches/goldLinkerUnixToolChains.patch
* https://github.com/futurejones/swift-arm64/raw/master/swift-for-tensorflow-patches/tensorflow_build_preset.patch
* https://github.com/futurejones/swift-arm64/raw/master/swift-for-tensorflow-patches/fix-aws-s3.patch


#### Build Info
Create source directory  
```mkdir swift-source && cd swift-source```

Clone Swift repository  
```git clone https://github.com/apple/swift.git```

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

