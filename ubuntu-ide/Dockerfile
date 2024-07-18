# Dockerfile
# Author: Alper Reha YAZGAN
# alperreha/bb-code:ubuntu22.04-term-ide-1.0.0

FROM node:18 as build

## ALpine
RUN apt-get update && \
    apt-get install -y make gcc g++ python3 libx11-dev libxkbfile-dev libc-dev libssl-dev curl gnupg git openssl rustc cargo


RUN npm i -g @vscode/spdlog

WORKDIR /tmp

# websocat build from source:
# Issue: https://github.com/vi/websocat/issues/240
# Resolved: https://github.com/vi/websocat/tree/e289e9f039169e2bc9df3c0b1aaf15a59f948aac
RUN git clone https://github.com/vi/websocat.git \
    && cd websocat \
    && git checkout e289e9f039169e2bc9df3c0b1aaf15a59f948aac

WORKDIR /tmp/websocat

RUN cargo build --release --features=ssl

# stage 3 - deploy
FROM nestybox/ubuntu-jammy-systemd:latest as deploy

LABEL org.opencontainers.image.authors="Alper Reha YAZGAN" \
    org.opencontainers.image.description="Bulut Bilisimciler Hands-on Lab IDE Environment - Alpine with ttyd, asciinema, websocat and some utilities" \
    org.opencontainers.image.documentation="https://bulutbilisimciler.com" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.title="Bulut Bilisimciler Alpine Terminal-IDE" \
    org.opencontainers.image.url="https://bulutbilisimciler.com" \
    org.opencontainers.image.vendor="TT" \
    org.opencontainers.image.version="2.0.0"

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
RUN apt-get update && \
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
    npm \
    # -- system \
    # dbus \
    # gnupg \
    make \
    # libx11-dev \
    # libxkbfile-dev \
    libc-dev \
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
    # websocat \
    nodejs \
    " \
    && apt install -y ${PACKAGES}

# rename binaries to aliases  (asciinema->bb-logger, ttyd->bb-terminal, nvim->vim)
RUN mv /usr/bin/asciinema /usr/bin/bb-logger
RUN mv /usr/bin/ttyd /usr/bin/bb-terminal
RUN mv /usr/bin/websocat /usr/bin/bb-streamer
RUN mv /usr/bin/nvim /usr/bin/vim

# section: install editor
ENV RELEASE_TAG="openvscode-server-v1.90.2" \
    RELEASE_ORG="gitpod-io" \
    CODE_ROOT="/root/.ide"

# create and set download dir
RUN mkdir -p ${CODE_ROOT} \
    && mkdir -p ${CODE_ROOT}/client-data \
    && mkdir -p ${CODE_ROOT}/server-data

# Downloading the latest VSC Server release and extracting the release archive
WORKDIR ${HOME}
RUN if [ -z "${RELEASE_TAG}" ]; then \
    echo "The RELEASE_TAG build arg must be set." >&2 && \
    exit 1; \
    fi && \
    arch=$(uname -m) && \
    if [ "${arch}" = "x86_64" ]; then \
    arch="x64"; \
    elif [ "${arch}" = "aarch64" ]; then \
    arch="arm64"; \
    elif [ "${arch}" = "armv7l" ]; then \
    arch="armhf"; \
    fi && \
    wget https://github.com/${RELEASE_ORG}/openvscode-server/releases/download/${RELEASE_TAG}/${RELEASE_TAG}-linux-${arch}.tar.gz && \
    tar -xzf ${RELEASE_TAG}-linux-${arch}.tar.gz -C ${HOME} && \
    mv ${HOME}/${RELEASE_TAG}-linux-${arch} ${CODE_ROOT}/app && \
    rm -f ${HOME}/${RELEASE_TAG}-linux-${arch}.tar.gz \
    # ADDITION: in this openvscode server node is not executable. Remove it and use current
    rm -rf ${CODE_ROOT}/app/node

# cp /usr/local/lib/node_modules/@vscode/spdlog/build/Release/spdlog.node /root/.openvscode-server/node_modules/@vscode/spdlog/build/Release/spdlog.node
COPY --from=build /usr/local/lib/node_modules/@vscode/spdlog/build/Release/spdlog.node \
    ${CODE_ROOT}/app/node_modules/@vscode/spdlog/build/Release/spdlog.node

# install extensions
ADD ./mounts/extensions.mini.json /tmp/extensions.json

SHELL ["/bin/bash", "-c"]
RUN urls=($(jq -r '.[] | .url' /tmp/extensions.json))\
    # Create a tmp dir for downloading
    && tdir=/tmp/exts && mkdir -p "${tdir}" && cd "${tdir}" \
    # Download via wget from $urls array.
    && wget "${urls[@]}" && \
    # List the extensions in this array
    exts=(\
    # From filesystem, .vsix that we downloaded (using bash wildcard '*')
    # "${tdir}"/* \
    # From filesystem, .vsix that we downloaded (using find)
    $(find "${tdir}" -type f -name "*.vsix") \
    )\
    # Install the $exts
    && echo "Installing extensions: ${exts[@]}" \ 
    # for ext in "${exts[@]}"; do /usr/bin/node ${CODE_ROOT}/app/out/server-main.js --extensions-dir ${CODE_ROOT}/app/extensions --install-extension "${ext}"; done 

# Clear cachse and unnecessary files and apk cache
RUN rm -rf /var/cache/apk/* \
    && rm -rf /tmp/* \
    && rm -rf /var/tmp/*

# Terminal Port is 40020
USER root
EXPOSE 40020
EXPOSE 3030
RUN mkdir -p /root/workspace
WORKDIR /root/workspace

# Start the bb-terminal server
# bash -c while true; do /usr/bin/bb-terminal -p 40020 -m 64 --writable -t disableLeaveAlert=true bash; done
# CMD 1 - Run Node App: /usr/bin/node /root/.ide/app/out/server-main.js --port 3030 --host 0.0.0.0 --default-workspace /root/workspace --default-folder /root/workspace --disable-workspace-trust --accept-server-license-terms --disable-telemetry --server-data-dir /root/.ide/server-data --user-data-dir /root/.ide/client-data --without-connection-token
# CMD 2 - Run TTYd Server: ttyd -p 40020 -m 64 --writable -t disableLeaveAlert=true bash
# CMD-3 - Delete Code Terminals: bash -c "while true; do kill -9 $(ps aux | grep '\-\-type=ptyHost' | awk '{print $1}'); sleep 3; done"
CMD [ "bash", "-c", "while true; do /usr/bin/bb-terminal -p 40020 -m 64 --writable -t disableLeaveAlert=true bash; done" ]
