# Building Swift With Docker
In these build instructions we will cover all the steps required from "Installing and testing Docker" and "Building Docker Images" to "Building Swift".  
The following steps are for a build server running Ubuntu 18.04.

## Step 1 - Installing Docker
* Requirments - git curl python apt-transport-https ca-certificates gnupg-agent software-properties-common  
```
sudo apt-get install git curl python apt-transport-https ca-certificates gnupg-agent software-properties-common
```
* Install docker repository
```
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=arm64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
```
* Install docker
```
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
sudo usermod -a -G docker $USER
```
* Test docker  
Open a new terminal window and run docker hello world
```
docker run hello-world
```
* This should return the following
```
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
 Docker is now installed. For more information go to [Docker Docs](https://docs.docker.com/engine/install/ubuntu/)
 