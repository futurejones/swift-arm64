## Build instructions for Swift for TensorFlow on Ubuntu 16.04 / 18.04

#### Development Dependencies Required
```sudo apt-get install git cmake ninja-build clang python uuid-dev libicu-dev icu-devtools libbsd-dev libedit-dev libxml2-dev libsqlite3-dev swig libpython-dev libncurses5-dev pkg-config libblocksruntime-dev libcurl4-openssl-dev systemtap-sdt-dev tzdata rsync```

#### Install Bazel Version >= 0.22.0
Add build-tools repository  
```curl -s https://packagecloud.io/install/repositories/swift-arm/build_tools/script.deb.sh | sudo bash```
Install Bazel  (This will install version 0.24.1)
```sudo apt-get install bazel```  
Additional Dependencies required for Bazel  
```sudo apt-get install build-essential openjdk-8-jdk zip unzip```

#### Patches Required.  
UPDATE: 25/05/2019  
The `tensorflow` branch has been updated and no longer requires the "VarArgs" or "goldLinker" patches. 
* https://github.com/futurejones/swift-arm64/raw/master/swift-for-tensorflow-patches/tensorflow_preset_mkldnn.patch  

UPDATE: 26/05/2019 aws fix is no longer needed as changes have been merged.


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

wget https://github.com/futurejones/swift-arm64/raw/master/swift-for-tensorflow-patches/tensorflow_preset_mkldnn.patch
git apply tensorflow_preset_mkldnn.patch

cd -
```

Patches are no longer needed to tensorflow directory  
```
```

Build Swift for TensorFlow  
NOTE: Replace [USER] with your user name.
```
./swift/utils/build-script --preset=tensorflow_linux,no_test install_destdir=/home/[USER]/swift-source/install installable_package=/home/[USER]/swift-source/install/swift-tensorflow-aarch64.tar.gz
```
#### Latest Pre-built binarys available here [swift-for-tensorflow-dev](https://github.com/futurejones/swift-arm64/releases/tag/swift-for-tensorflow-dev)

UPDATE 2019-02-07: MKL-DNN contraction kernels are now built by default.  
MKL-DNN is compatible with x86_64 only so this needs to be disabled in the build preset.  
`tensorflow_bazel_options=--define=tensorflow_mkldnn_contraction_kernel=0` has been added with the `tensorflow_preset_mkldnn.patch`.

UPDATE 2019-05-06: The `build_presets` patch has been updated to use the `tensorflow_linux` presets.  
Presets available are:  
`tensorflow_linux`  
`tensorflow_linux,no_test`  
`tensorflow_linux,gpu`  
`tensorflow_linux,gpu,no_test`
