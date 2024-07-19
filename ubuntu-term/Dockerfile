# Dockerfile
# Author: Alper Reha YAZGAN
# alperreha/bb-ubuntu:22.04-term-v1.0.0
FROM node:18 as build

## ALpine
RUN apt-get update && \
    apt-get install -y make gcc g++ python3 libx11-dev libxkbfile-dev libc-dev libssl-dev curl gnupg git openssl rustc cargo

# use temporary directory
WORKDIR /tmp

# websocat build from source:
# Issue: https://github.com/vi/websocat/issues/240
# Resolved: https://github.com/vi/websocat/tree/e289e9f039169e2bc9df3c0b1aaf15a59f948aac
RUN git clone https://github.com/vi/websocat.git \
    && cd websocat \
    && git checkout e289e9f039169e2bc9df3c0b1aaf15a59f948aac

WORKDIR /tmp/websocat

RUN cargo build --release --features=ssl

# stage 2 - deploy
FROM nestybox/ubuntu-jammy-systemd:latest as deploy

LABEL org.opencontainers.image.authors="Alper Reha YAZGAN" \
    org.opencontainers.image.description="Bulut Bilisimciler Hands-on Lab IDE Environment - Ubuntu 22.04 with ttyd, asciinema, websocat and some utilities" \
    org.opencontainers.image.documentation="https://bulutbilisimciler.com" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.title="Bulut Bilisimciler Ubuntu Terminal" \
    org.opencontainers.image.url="https://bulutbilisimciler.com" \
    org.opencontainers.image.vendor="TT" \
    org.opencontainers.image.version="1.0.0"

# Predefined env variables
ENV TERM=xterm \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=C.UTF-8 \
    LANG=C.UTF-8 \
    TZ="Europe/Istanbul" \
    DEBIAN_FRONTEND=noninteractive \
    USE_LOCAL_GIT=true \
    SHELL=/bin/bash \
    HOME=/root

# Copy files from directory
# bash.bashrc
ADD ./mounts/bash.bashrc ${HOME}/.bashrc
ADD ./mounts/bash.bashrc ${HOME}/.bash_profile

ADD ./mounts/motd /etc/motd
COPY --from=build /tmp/websocat/target/release/websocat /usr/bin/websocat

# Update and upgrade
RUN apt-get update -y && \
    apt-get upgrade -y

# Install packages
# IGNORE: additional package not required right now: python3, vim, gcc, g++, alpine-sdk 
RUN set -eux \
    && PACKAGES=" \
    # -- built-in \
    bash \
    tzdata \
    wget \
    curl \
    git \
    ripgrep \
    # -- system \
    libssl-dev \
    # -- custom \
    jq \
    # -- logging \
    openssh-client \
    asciinema \
    ttyd \
    neovim \
    tmux \
    screen \
    " \
    && apt install -y ${PACKAGES} \
    && apt-get clean 

# Clear cache and unnecessary files and apk cache
RUN rm -rf /var/cache/apk/* \
    && rm -rf /tmp/* \
    && rm -rf /var/tmp/* \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# rename binaries to aliases  (asciinema->bb-logger, ttyd->bb-terminal, nvim->vim)
RUN mv /usr/bin/asciinema /usr/bin/bb-logger
RUN mv /usr/bin/ttyd /usr/bin/bb-terminal
RUN mv /usr/bin/websocat /usr/bin/bb-streamer
RUN mv /usr/bin/nvim /usr/bin/vim

# Terminal Port is 40020
USER root
EXPOSE 40020
RUN mkdir -p /root/workspace
WORKDIR /root/workspace

# Inject BB Terminal Service
COPY ./services/bb-terminal-service.sh /usr/bin/
COPY ./services/bb-terminal.service /lib/systemd/system/

# Link service to systemd
RUN chmod +x /usr/bin/bb-terminal-service.sh && \
    ln -sf /lib/systemd/system/bb-terminal.service \
    /etc/systemd/system/multi-user.target.wants/bb-terminal.service