### rockylinux8-term

This is the rockylinux8 image. It is based on the rockylinux:8 image and has the ttyd installed. It is used to run the terminal in the browser.


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
cd rockylinux8-term

# buildx
docker buildx build --platform linux/amd64 --memory 12 -t alperreha/bb-rockylinux:8-term-v1.0.0 .
# build
docker build --platform linux/amd64 -t alperreha/bb-rockylinux:8-term-v1.0.0 .

# run
docker run --privileged -it --rm -p 40020:40020 --name=bb-rockylinux-8-term-1.0.0 alperreha/bb-rockylinux:8-term-v1.0.0
```


### Changelog

- [x] 1.0.0: ttyd, websocat, tmux, screen, asciinema, neovim installed and boilerplate ready.
  This release supports "systemctl" commands due to container starts with "/sbin/init".
  
