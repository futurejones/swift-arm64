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

Install Swift - 

```bash
$ sudo apt-get install swift4
```

### Tested Boards and OS's

*Rock64* - Debian/Stretch Unbutu/Xenial  
*RaspberryPi 3* - Debian 10 64bit preview  
*ODROID-C2* - Ubuntu 16.04.4 LTS xenial

### RaspberyPi 3 64bit OS

An official 64 bit Ubuntu "Bionic" 18.04 install image is now available for Raspberry Pi 3.

Note: This is a lite server image for headless operation.

Download image here - http://cdimage.ubuntu.com/releases/18.04/beta/

Swift 4.2 AArch64 for Ubuntu 18.04 is available here - https://packagecloud.io/swift-arm/release/packages/ubuntu/bionic/swift4_4.2_arm64.deb

