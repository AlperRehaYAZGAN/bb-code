### alpine-term-docker

Everything is same with base alpine-term image. But in addition, it has apk docker installed and dockerd supervisor service is added.


### Environment Requirements

This repository uses the following tools for building:
- Docker
- Nestybox/sysbox  

You need to install these tools to build the images. Ubuntu 22.04 machine is required to build the images due to nestybox/sysbox restrictions.  

```bash
# install docker ...

# install sysbox requirements
sudo apt install jq

# install sysbox  
# 2024-07-22: https://github.com/nestybox/sysbox/releases/tag/v0.6.4
wget https://downloads.nestybox.com/sysbox/releases/v0.6.4/sysbox-ce_0.6.4-0.linux_amd64.deb
sudo apt install ./sysbox-ce_0.6.4-0.linux_amd64.deb

# restart docker
sudo systemctl stop docker
sudo systemctl start docker

# clone repository
git clone https://github.com/AlperRehaYAZGAN/bb-code.git
cd bb-code
```

### Build and Run


```bash
# start building.
cd alpine-term-compose

# buildx
docker buildx build --platform linux/amd64 --memory 12 -t alperreha/bb-alpine:3.19-term-compose-v1.0.0 .
# build
docker build --platform linux/amd64 -t alperreha/bb-alpine:3.19-term-compose-v1.0.0 .

# run
docker run --privileged -it --rm -p 40020:40020 --name=bb-alpine3.19-term-compose-1.0.0 alperreha/bb-alpine:3.19-term-compose-v1.0.0
```


### Changelog

- [x] 1.0.0: Main base alpine image with supervisor application inherit from alperreha/bb-alpine:3.19-term-v2.0.0.  This version included docker and dockerd service.
