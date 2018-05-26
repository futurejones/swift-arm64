# Swift-Arm64
Swift for Arm64/aarch64 SBC's - Rock64, RaspberryPi3 and many more

Install package now available for arm64/aarch64 compatible SBC's.

for Debian/Stretch

Tested on the Rock64 from http://pine64.org

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

### RaspberyPi 3 64bit OS

A 64 bit Debian 10 "Buster" preview with Swift 4.1.1 pre-installed is available for testing.

Note: This is a lite server image for headless operation.

https://github.com/futurejones/swift-arm64/releases/download/rpi3-debian-buster-64bit/debian_10_64bit_rpi3.img.tar.gz

- Download and untar
- copy "bionic_rpi3.img" image to sd card
- boot and `ssh pi@rpi3.local`
- username "pi"
- password "raspberry"

Test with some server side swift examples from Kitura
```bash
$ git clone https://github.com/IBM-Swift/Kitura-Sample.git
$ cd Kitura-Sample
$ swift build
$ swift run Kitura-Sample
```

