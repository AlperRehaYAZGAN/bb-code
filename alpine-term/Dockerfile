# Dockerfile
# Author: Alper Reha YAZGAN
# alperreha/bb:alpine3.19-term-2.0.0

# One Stage Dockerfile
FROM alpine:3.19

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

# Configure the terminal
RUN echo '[ ! -z "$TERM" -a -r /etc/motd ] && cat /etc/motd' \
    >> /etc/bash.bashrc \
    && echo "$(cat /etc/os-release | awk 'NR==2, NR==5{print}')" >> /etc/motd

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
    # s3cmd \
    tmux \
    screen \
    websocat \
    " \
    && apk add --no-cache ${PACKAGES}

# rename binaries to aliases  (asciinema->bb-logger, ttyd->bb-terminal, nvim->vim)
RUN mv /usr/bin/asciinema /usr/bin/bb-logger
RUN mv /usr/bin/ttyd /usr/bin/bb-terminal
RUN mv /usr/bin/nvim /usr/bin/vim

# Clear cache and unnecessary files and apk cache
RUN rm -rf /var/cache/apk/* \
    && rm -rf /tmp/* \
    && rm -rf /var/tmp/*

# Copy files from directory
# bash.bashrc
ADD ./mounts/bash.bashrc /etc/bash.bashrc
ADD ./mounts/bash.bashrc /root/.bashrc
ADD ./mounts/motd /root/workspace/motd

# Terminal Port is 40020
USER root
EXPOSE 40020
RUN mkdir -p /root/workspace
WORKDIR /root/workspace

# Start the bb-terminal server
# bash -c while true; do /usr/bin/bb-terminal -p 40020 -m 64 --writable -t disableLeaveAlert=true bash; done
CMD [ "bash", "-c", "while true; do /usr/bin/bb-terminal -p 40020 -m 64 --writable -t disableLeaveAlert=true bash; done" ]