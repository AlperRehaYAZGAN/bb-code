### pardus-term-extended

Everything is same with base pardus-term image. But in addition, it has apt some packages installed and systemctl enabled.


### Environment Requirements

This repository uses the following tools for building:
- Docker
- Nestybox/sysbox  

You need to install these tools to build the images. pardus 23 machine is required to build the images due to nestybox/sysbox restrictions.  

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
cd pardus-term-extended

# buildx
docker buildx build --platform linux/amd64 --memory 12 -t alperreha/bb-pardus:23-term-extended-v1.0.0 .
# build
docker build --platform linux/amd64 -t alperreha/bb-pardus:23-term-extended-v1.0.0 .

# run
docker run --privileged -it --rm -p 40020:40020 --name=bb-pardus23-term-extended-1.0.0 alperreha/bb-pardus:23-term-extended-v1.0.0
```


### Changelog

- [x] 1.0.0: Main pardus image used to biuld get.docker.io shell script. Just docker and compsoe installed. dockerd enabled.

