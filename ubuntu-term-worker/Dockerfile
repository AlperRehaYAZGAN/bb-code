# Dockerfile
# Author: Alper Reha YAZGAN
# alperreha/bb-ubuntu:22.04-term-worker-v1.0.0
# stage 1 - build
FROM alperreha/bb-ubuntu:22.04-term-v1.0.0


LABEL org.opencontainers.image.authors="Alper Reha YAZGAN" \
    org.opencontainers.image.description="Bulut Bilisimciler Hands-on Lab Environment - Ubuntu 22.04 K8S CRI-O, ttyd, asciinema, websocat and some utilities" \
    org.opencontainers.image.documentation="https://bulutbilisimciler.com" \
    org.opencontainers.image.licenses="GPL v2.0" \
    org.opencontainers.image.title="Bulut Bilisimciler Ubuntu 22.04 Kubernetes Worker Terminal-Only" \
    org.opencontainers.image.url="https://bulutbilisimciler.com" \
    org.opencontainers.image.vendor="TT" \
    org.opencontainers.image.version="1.0.0"


# Install CRI-O required packages
RUN apt-get update && \
    apt-get install -y \ 
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common

# env from build args
ARG OS=xUbuntu_20.04
ARG CRIO_VERSION=1.30.3


# Add CRI-O repository
RUN echo "deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/$OS/ /"| sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list \
    echo "deb http://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable:/cri-o:/$CRIO_VERSION/$OS/ /"|sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable:cri-o:$CRIO_VERSION.list

# Add CRI-O repository key
RUN curl -L https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable:cri-o:$CRIO_VERSION/$OS/Release.key | apt-key add - \
    curl -L https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/$OS/Release.key | apt-key add -

# install cri-o
RUN apt-get update && \
    apt install -y \ 
    cri-o cri-o-runc cri-tools \
    containernetworking-plugins


# Uncomment network_dir & plugin_dirs section and also add ‘/usr/lib/cni/’ under plugin_dirs section
RUN sed -i 's/#network_dir = "\/etc\/cni\/net.d"/network_dir = "\/etc\/cni\/net.d"/g' /etc/crio/crio.conf \
    sed -i 's/#plugin_dirs = \["\/usr\/lib\/cni\/"\]/plugin_dirs = \["\/usr\/lib\/cni\/"\]/g' /etc/crio/crio.conf

# install kubectl
RUN apt-get update && \
    apt-get install -y kubectl

# remove unnecessary files in ubuntu before commit
RUN rm -rf /var/cache/apt/* \
    /var/tmp/* \
    && apt-get clean

