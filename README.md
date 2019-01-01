## Latest build info from our CI server
The awesome Cavium ThunderX from [Packet Bare Metal Servers](https://www.packet.com/cloud/servers/c1-large-arm/)

### Swift 4.1.3 &nbsp; [![Build Status](http://futurejones.xyz:8080/job/swift-4.1-branch-aarch64/badge/icon)](http://futurejones.xyz:8080/job/swift-4.1-branch-aarch64)   
### Swift 4.2.1 &nbsp; [![Build Status](http://futurejones.xyz:8080/job/swift-4.2-aarch64-RELEASE/5/badge/icon)](http://futurejones.xyz:8080/job/swift-4.2-aarch64-RELEASE)
### Swift 5.0 &nbsp;&nbsp;&nbsp;&nbsp; [![Build Status](http://futurejones.xyz:8080/job/swift-5.0-aarch64/badge/icon)](http://futurejones.xyz:8080/job/swift-5.0-aarch64)
### Master &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [![Build Status](http://futurejones.xyz:8080/job/swift-master-aarch64/badge/icon)](http://futurejones.xyz:8080/job/swift-master-aarch64)

# Swift-Arm64
Swift for Arm64/aarch64 SBC's - Rock64, RaspberryPi3 and many more

Install package now available for arm64/aarch64 compatible SBC's.

for Debian/Stretch

Tested on the Rock64 from [http://pine64.org](http://pine64.org)

Add repo -

```bash
$ curl -s https://packagecloud.io/install/repositories/swift-arm/debian/script.deb.sh | sudo bash
```  
For new Ubuntu 18.04 64bit Paspberry Pi 3 models use this repo -  

```bash
$ curl -s https://packagecloud.io/install/repositories/swift-arm/release/script.deb.sh | sudo bash
``` 

Install Swift - 

```bash
$ sudo apt-get install swift4
```

### Tested Boards and OS's

*Rock64* - Debian/Stretch Ubuntu/Xenial  
*RaspberryPi 3 models* - Ubuntu 18.04 64bit  
*ODROID-C2* - Ubuntu 16.04.4 LTS xenial

### RaspberyPi 3 64bit OS

An official 64 bit Ubuntu "Bionic" 18.04 install image is now available for Raspberry Pi 3.

*Note: This is a lite server image for headless operation.*  
*Tested on RPi3B and RPi3B+.*  
*Should also install on RPi3A+ and maybe the Compute Module 3.*

Download image here - [http://cdimage.ubuntu.com/releases/18.04/beta/](http://cdimage.ubuntu.com/releases/18.04/beta/)

Swift 4.2 AArch64 for Ubuntu 18.04 is available here - [swift4_4.2_arm64.deb](https://packagecloud.io/swift-arm/release/packages/ubuntu/bionic/swift4_4.2_arm64.deb)

## Swift 5.0 Developer Snapshots
Swift 5.0 developer snapshots are now available for Ubuntu 16.04.  
Download here - [Snapshots](https://github.com/futurejones/swift-arm64/releases)

## Building Swift

*Swift development on AArch64 systems is currently possible on Ubuntu 16.04 and 18.04.*  
*The following build instructions are for Ubuntu 16.04.*

### Setting up the Swift development environment
* If possible start with a new clean install of Ubuntu 16.04 and then update and upgrade your system:  
```$ sudo apt-get update```  
```$ sudo apt-get upgrade```
* Install development dependencies:  
```$ sudo apt-get install git cmake ninja-build clang python uuid-dev libicu-dev icu-devtools libbsd-dev libedit-dev libxml2-dev libsqlite3-dev swig libpython-dev libncurses5-dev pkg-config libblocksruntime-dev libcurl4-openssl-dev systemtap-sdt-dev tzdata rsync```  

### Getting Sources for Swift and Related Projects
* First create a directory for all of the Swift sources:  
```mkdir swift-source```  
```cd swift-source```

* Next clone the Swift repository:  
```$ git clone https://github.com/apple/swift.git```

* Next use the "update-checkout" utility to clone the related repositories. When using this utility we can use either a `--tag` to specify a release or `--scheme` to specify a branch. If no tag or scheme is used then the master will be used as default.  
The following command will clone and checkout all necessary repositories to build a 4.2.1 release.  
```$ ./swift/utils/update-checkout --clone --tag swift-4.2.1-RELEASE```  
The following command will clone and checkout all necessary repositories to build the swift-5.0-branch.  
```$ ./swift/utils/update-checkout --clone --scheme swift-5.0-branch```

### Applying Patches
* Some branches require additional patches for successful builds.  
  * swift-4.2-branch:  
  ```$ cd swift```  
  ```$ wget https://github.com/futurejones/swift-arm64/raw/master/swift-4.2-patches/swift-4.2-aarch64-VarArgs.patch```  
  ```$ git apply swift-4.2-aarch64-VarArgs.patch```  
  ```$ wget https://github.com/futurejones/swift-arm64/raw/master/swift-4.2-patches/swift-4.2-pm-fix.patch```  
  ```$ git apply swift-4.2-pm-fix.patch```  
  ```$ cd -```
  
  * swift-5.0-branch:  
  ```$ cd swift```  
  ```$ wget https://github.com/futurejones/swift-arm64/raw/master/master-patches/aarch64-new-master-VarArgs.patch```  
  ```$ git apply aarch64-new-master-VarArgs.patch```  
  ```$ cd -```

  * master:  
  No patches required.

### Building with Ninja
* The ```build-script``` is a high-level build automation script that supports basic options such as building a Swift-compatible LLDB, building the Swift Package Manager, building for various platforms, running tests after builds, and more.  
We will be using ```buildbot_linux``` presets to specify OS, install directories and package names.  
*NOTE: Replace [USER] with your user name. You should also rename "swift-4.2.1-aarch64-RELEASE-Ubuntu-16.04.tar.gz" tarball to match your build if needed*  
```$ ./swift/utils/build-script --preset=buildbot_linux,no_test install_destdir=/home/[USER]/swift-source/install installable_package=/home/[USER]/swift-source/install/swift-4.2.1-aarch64-RELEASE-Ubuntu-16.04.tar.gz -n```  
Using the "-n" tag on the end of the command enables a "dry run" to check the commands are correct before running the actual build.  
If everything is correct then you can remove "-n" and proceed with the build.  
Depending on your build system the build can take from 1.5hrs to 15hrs or more.  
