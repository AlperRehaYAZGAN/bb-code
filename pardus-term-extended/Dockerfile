# Dockerfile
# Author: Alper Reha YAZGAN
# aalperreha/bb-pardus:23-term-v1.0.0
# stage 1 - build
FROM alperreha/bb-pardus:23-term-v1.0.0

LABEL org.opencontainers.image.authors="Alper Reha YAZGAN" \
    org.opencontainers.image.description="Bulut Bilisimciler Hands-on Lab Environment - Pardus 23 withttyd, asciinema, websocat and some utilities" \
    org.opencontainers.image.documentation="https://bulutbilisimciler.com" \
    org.opencontainers.image.licenses="GPL v2.0" \
    org.opencontainers.image.title="Bulut Bilisimciler Pardus 23 Terminal-Only" \
    org.opencontainers.image.url="https://bulutbilisimciler.com" \
    org.opencontainers.image.vendor="TT" \
    org.opencontainers.image.version="1.0.0"

# Update and upgrade
RUN apt-get update -y && \
    apt-get upgrade -y

# Install packages
# IGNORE: additional package not required right now: python3, vim, gcc, g++, alpine-sdk 
RUN set -eux \
    && PACKAGES=" \
    # -- pardus special \
    systemd \
    systemd-sysv \
    libsystemd0 \
    ca-certificates \
    dbus \
    man-db \
    # -- system \
    man \
    procps \
    manpages-tr \
    file \
    pciutils \
    neofetch \
    usbutils \
    nano \
    sl \
    tree \
    locate \
    lsb-release \
    htop \
    iputils-ping \
    bc \
    iptables \
    iproute2 \
    kmod \
    locales \
    plocate \
    sudo \
    udev \
    " \
    && apt install -y ${PACKAGES} \
    && apt-get clean \
    && rm -rf /var/cache/apt/* \
    /var/tmp/*
