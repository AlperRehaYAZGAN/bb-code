# Dockerfile
# Author: Alper Reha YAZGAN
# alperreha/bb-alpine:3.19-term-v2.0.0
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
    org.opencontainers.image.description="Bulut Bilisimciler Hands-on Lab Environment - Alpine with ttyd, asciinema, websocat and some utilities" \
    org.opencontainers.image.documentation="https://bulutbilisimciler.com" \
    org.opencontainers.image.licenses="GPL v2.0" \
    org.opencontainers.image.title="Bulut Bilisimciler Alpine Terminal-Only" \
    org.opencontainers.image.url="https://bulutbilisimciler.com" \
    org.opencontainers.image.vendor="TT" \
    org.opencontainers.image.version="2.0.0"

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
# docker-entrypoint.sh
ADD ./mounts/docker-entrypoint.sh /usr/bin/docker-entrypoint.sh
RUN chmod +x /usr/bin/docker-entrypoint.sh

# bash.bashrc
ADD ./mounts/bash.bashrc ${HOME}/.bashrc
ADD ./mounts/bash.bashrc ${HOME}/.bash_profile

# motd and websocat
ADD https://gitlab.bulutbilisimciler.com/bb-public/playground-init/-/raw/main/motd /root/workspace/motd
ADD https://gitlab.bulutbilisimciler.com/bb-public/playground-init/-/raw/main/motd /etc/motd
COPY --from=build /tmp/websocat/target/release/websocat /usr/bin/websocat

# supervisor confs
# supervisord
RUN mkdir -p /var/log/supervisor && \
    mkdir -p /etc/supervisor.d

# move services to supervisor conf.d
ADD ./services/bb-terminal.ini /etc/supervisor.d/
ADD ./services/bb-on-init.ini /etc/supervisor.d/
ADD ./services/bb-terminal.sh /usr/bin/
RUN chmod +x /usr/bin/bb-terminal.sh
ADD ./services/bb-on-init.sh /usr/bin/
RUN chmod +x /usr/bin/bb-on-init.sh

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
    libressl-dev \
    # -- logging \
    openssh-client \
    asciinema \
    # ttyd \
    neovim \
    tmux \
    screen \
    # nestybox multiple services \
    supervisor \
    " \
    && apk add --no-cache ${PACKAGES}

# Install ttyd manually due to Ubuntu apt installs old version. 
# it uses old version but we need latest. 
# e.g. https://manpages.ubuntu.com/manpages/jammy/en/man1/ttyd.1.html
RUN wget https://github.com/tsl0922/ttyd/releases/download/1.7.7/ttyd.x86_64 -O /usr/bin/bb-terminal \
    && chmod +x /usr/bin/bb-terminal

# Copy files from directory
ADD ./mounts/image.env /tmp/image.env

# rename binaries to aliases  (asciinema->bb-logger, ttyd->bb-terminal, nvim->vim)
# RUN mv /usr/bin/ttyd /usr/bin/bb-terminal
RUN mv /usr/bin/asciinema /usr/bin/bb-logger
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
# CMD [ "bash", "-c", "while true; do /usr/bin/bb-terminal -p 40020 -m 64 --writable -t disableLeaveAlert=true bash; done" ]
CMD [ "/usr/bin/docker-entrypoint.sh" ]