# Dockerfile
# Author: Alper Reha YAZGAN
# alperreha/bb:alpine3.19-term-2.0.0
# stage 1 - build
FROM node:18-alpine3.19 as build

RUN apk update && \
    apk add --no-cache make gcc g++ python3 libx11-dev libxkbfile-dev libsecret-dev libc-dev libsecret curl gnupg git openssl libressl-dev rust cargo

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
FROM alpine:3.19 as deploy

LABEL org.opencontainers.image.authors="Alper Reha YAZGAN" \
    org.opencontainers.image.description="Bulut Bilisimciler Hands-on Lab Environment - Alpine with ttyd, asciinema and some utilities" \
    org.opencontainers.image.documentation="https://bulutbilisimciler.com" \
    org.opencontainers.image.licenses="GPL v2.0" \
    org.opencontainers.image.title="Bulut Bilisimciler Alpine Terminal-Only" \
    org.opencontainers.image.url="https://bulutbilisimciler.com" \
    org.opencontainers.image.vendor="TT" \
    org.opencontainers.image.version="0.0.1"

# Predefined env variables
ENV TERM=xterm \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=C.UTF-8 \
    LANG=C.UTF-8 \
    TZ="Europe/Istanbul" \
    USE_LOCAL_GIT=true \
    SHELL=/bin/bash \
    HOME=/root

# Copy files from directory
# bash.bashrc
ADD ./mounts/bash.bashrc ${HOME}/.bashrc
ADD ./mounts/bash.bashrc ${HOME}/.bash_profile

ADD ./mounts/motd /root/workspace/motd
ADD ./mounts/motd /etc/motd
COPY --from=build /tmp/websocat/target/release/websocat /usr/bin/websocat

# Update and upgrade
RUN apk update \
    && apk upgrade

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
    openrc \
    # -- system \
    dbus \
    gnupg \
    make \
    libx11-dev \
    libxkbfile-dev \
    libsecret-dev \
    libc-dev \
    libsecret \
    # -- custom \
    jq \
    # -- logging \
    openssh-client \
    asciinema \
    ttyd \
    neovim \
    tmux \
    screen \
    # s3cmd \
    # websocat \
    " \
    && apk add --no-cache ${PACKAGES}

# rename binaries to aliases  (asciinema->bb-logger, ttyd->bb-terminal, nvim->vim)
RUN mv /usr/bin/asciinema /usr/bin/bb-logger
RUN mv /usr/bin/ttyd /usr/bin/bb-terminal
RUN mv /usr/bin/websocat /usr/bin/bb-streamer
RUN mv /usr/bin/nvim /usr/bin/vim

# Clear cache and unnecessary files and apk cache
RUN rm -rf /var/cache/apk/* \
    && rm -rf /tmp/* \
    && rm -rf /var/tmp/*

# Terminal Port is 40020
USER root
EXPOSE 40020
RUN mkdir -p /root/workspace
WORKDIR /root/workspace

# Start the bb-terminal server
# bash -c while true; do /usr/bin/bb-terminal -p 40020 -m 64 --writable -t disableLeaveAlert=true bash; done
CMD [ "bash", "-c", "while true; do /usr/bin/bb-terminal -p 40020 -m 64 --writable -t disableLeaveAlert=true bash; done" ]