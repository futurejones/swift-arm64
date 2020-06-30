# Building Swift With Docker
In these build instructions we will cover all the steps required from "Installing and testing Docker" and "Building Docker Images" to "Building Swift".  
The following steps are for a build server running Ubuntu 18.04.

# Step 1 - Installing Docker
* Requirements - git curl python apt-transport-https ca-certificates gnupg-agent software-properties-common  
```
sudo apt-get install git curl python apt-transport-https ca-certificates gnupg-agent software-properties-common
```
* Install docker repository
```bash
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=arm64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
```
* Install docker
```bash
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
sudo usermod -a -G docker $USER
```
* Test docker  
Open a new terminal window and run docker hello world
```bash
docker run hello-world
```
* This should return the following
```bash
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
256ab8fe8778: Pull complete 
Digest: sha256:d58e752213a51785838f9eed2b7a498ffa1cb3aa7f946dda11af39286c3db9a9
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (arm64v8)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/
 ```
 Docker is now installed. For more information on Docker installation go to [Docker Docs](https://docs.docker.com/engine/install/ubuntu/)

# Building Docker Images - The Dockerfile
Docker images are built from `Dockerfiles`. The `Dockerfiles` used for building `swift-arm` are based on the official `Dockerfiles` from [swift-docker](https://github.com/apple/swift-docker/tree/master/swift-ci).

## An Example Dockerfile for Ubuntu 20.04
```docker
# Ubuntu Focal 20.04

FROM ubuntu:20.04

RUN groupadd -g 998 build-user && \
    useradd -m -r -u 42 -g build-user build-user

ENV DEBIAN_FRONTEND="noninteractive"

RUN apt-get update

RUN apt-get -y install      \
    wget                    \
    build-essential         \
    clang                   \
    cmake                   \
    git                     \
    icu-devtools            \
    libcurl4-openssl-dev    \
    libedit-dev             \
    libicu-dev              \
    libncurses5-dev         \
    libsqlite3-dev          \
    libssl-dev              \
    libxml2-dev             \
    ninja-build             \
    pkg-config              \
    python                  \
    python-six              \
    rsync                   \
    swig                    \
    systemtap-sdt-dev       \
    tzdata                  \
    unzip                   \
    uuid-dev

RUN git clone https://github.com/Kitware/CMake.git && cd CMake && git checkout v3.16.6 && ./bootstrap --prefix=/usr && make && make install

USER build-user

WORKDIR /home/build-user
```
More examples here - [Dockerfiles](https://github.com/futurejones/swift-arm64/tree/master/swift-ci-docker)

# Step 2 - Building a Docker Image
* Create a build directory
```bash
mkdir docker-build
cd docker-build
```
* In the build directory create a file called `Dockerfile` and copy paste the example code from above.
* Run the following docker build command.  
```bash
docker build -f <dockerfile path> . --tag <image-name>
```  
By default docker will look for and build the `Dockerfile` if you don't specify a file path.
```bash
docker build . --tag ubuntu_20.04
```
* After several minutes you should see something similar to the following message.
```bash
Successfully built eaecd8eb821c
Successfully tagged ubuntu_20.04:latest
```
For more info on building docker images go to the [Docker Docs](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)

## Using Docker Hub
Instead of building your own docker images you can use pre-built images from [DockerHub](https://hub.docker.com/)  
The [swiftarm](https://hub.docker.com/u/swiftarm) docker hub repository contains a number of pre-built images ready to use for building `swift`

# Step 3 - Downloading The Swift Source Code
* First we will create 2 new directories. One for the Swift source code and one to hold the compiled install package.
```bash
mkdir swift-source
mkdir output
```
* Next clone the swift and all the supporting repositories in the swift-source directory
```bash
cd swift-source
git clone https://github.com/apple/swift.git
./swift/utils/update-checkout --clone --scheme master
```
Now that we have the `source code` we are ready to use the docker `image` to create a docker `container` and build `swift`

# Step 4 - Building Swift
* If you are using `Docker Hub` you will first need to pull the latest docker image.
```bash
docker pull swiftarm/ubuntu_focal
```
* Use `docker run` to create a container and build `swift`. In this build command you will see several security options and tags used. Please read the [Docker Docs](https://docs.docker.com/engine/reference/commandline/container_run/) for detailed info on each of these items.
```bash
docker run \
--cap-add=SYS_PTRACE \
--security-opt seccomp=unconfined \
--name swift-ubuntu-focal \
-w /home/build-user \
-v ~/swift-source:/source \
-v swift-ubuntu-focal:/home/build-user \
swiftarm/ubuntu_focal \
/bin/bash -lc \
'cp -r /source/* /home/build-user; \
./swift/utils/build-script \
--preset buildbot_linux,no_test \
install_destdir=/home/build-user/swift-install \
installable_package=/home/build-user/output/swift-ubuntu-focal-master-aarch64.tar.gz'
```
Command details:-
```docker
docker run \
--cap-add=SYS_PTRACE \
--security-opt seccomp=unconfined \
--name swift-ubuntu-focal \                 # Name of the container
-w /home/build-user \                       # Name of the work directory - matches the Dockerfile
-v ~/swift-source:/source \                 # Mounted volume for swift source
-v swift-ubuntu-focal:/home/build-user \    # Mounted volume for home directory
swiftarm/ubuntu_focal \                     # Name of docker image being used
/bin/bash -lc \
# bash commands run inside the container 1:copy swift-source to mounted volume 2:build swift
'cp -r /source/* /home/build-user; \ 
./swift/utils/build-script \
--preset buildbot_linux,no_test \
install_destdir=/home/build-user/swift-install \
installable_package=/home/build-user/output/swift-ubuntu-focal-master-aarch64.tar.gz'
```
When the build has finished you will be returned to the command prompt.

# Step 5 - Copy Installable Package.
As the installable package is still inside the docker container we will need to copy it to the `output` directory.
```bash
docker cp swift-ubuntu-focal:/home/build-user/output/swift-ubuntu-focal-master-aarch64.tar.gz output/
```
```bash
docker cp <container name>:<absolute path to file> <destination directory>/
```

We should now have the `swift installable package` in the `output` directory that we created earlier.

# Building for Other Linux Distributions.
You can now build `swift` the following Linux distributions using docker containers.
* [Ubuntu 16.04](https://hub.docker.com/r/swiftarm/ubuntu_xenial)
* [Ubuntu 18.04](https://hub.docker.com/r/swiftarm/ubuntu_bionic)
* [Ubuntu 20.04](https://hub.docker.com/r/swiftarm/ubuntu_focal)
* [Debian 10](https://hub.docker.com/r/swiftarm/debian_10)
* [Amazon Linux 2](https://hub.docker.com/r/swiftarm/amzn_2)
* [CentOS 8](https://hub.docker.com/r/swiftarm/centos_8)

Other distributions may also be possible but they haven't been tested yet.
