# Dockerfile
# Author: Alper Reha YAZGAN
# alperreha/bb-rockylinux:8-term-v1.0.0
FROM rockylinux:8 as build

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

## Prepare dependencies for rust
RUN dnf install epel-release -y \
    && dnf install cmake gcc make curl clang git openssl-devel rust cargo -y

# use temporary directory
WORKDIR /tmp

# websocat build from source:
# Issue: https://github.com/vi/websocat/issues/240
# Solved in: https://github.com/vi/websocat/issues/243
# Resolved: https://github.com/vi/websocat/tree/e289e9f039169e2bc9df3c0b1aaf15a59f948aac
RUN git clone https://github.com/vi/websocat.git \
    && cd websocat \
    && git checkout e289e9f039169e2bc9df3c0b1aaf15a59f948aac

WORKDIR /tmp/websocat

RUN cargo build --release --features=ssl

# stage 2 - deploy
# https://github.com/nestybox/dockerfiles/blob/master/ubuntu-jammy-systemd/Dockerfile
###################################### Boilerplate START ######################################
# https://github.com/nestybox/dockerfiles/blob/master/rockylinux-8-systemd/Dockerfile
FROM rockylinux:8 as deploy

#
# Systemd installation
#
RUN dnf update -y \
    && dnf install -y \
    iptables   \
    iproute    \
    kmod       \
    procps-ng  \
    sudo       \
    udev &&    \
    # Unmask services
    systemctl unmask                                                  \
    systemd-remount-fs.service                                    \
    dev-hugepages.mount                                           \
    sys-fs-fuse-connections.mount                                 \
    systemd-logind.service                                        \
    getty.target                                                  \
    console-getty.service &&                                      \
    # Prevents journald from reading kernel messages from /dev/kmsg
    echo "ReadKMsg=no" >> /etc/systemd/journald.conf &&               \
    \
    # Housekeeping
    dnf clean all &&                                                  \
    rm -rf                                                            \
    /var/cache/dnf/*                                               \
    /var/log/*                                                     \
    /tmp/*                                                         \
    /var/tmp/*                                                     \
    /usr/share/doc/*                                               \
    /usr/share/man/* &&                                            \
    \
    # Create default 'admin/admin' user
    useradd --create-home --shell /bin/bash admin -G wheel && echo "admin:admin" | chpasswd

# Make use of stopsignal (instead of sigterm) to stop systemd containers.
STOPSIGNAL SIGRTMIN+3
###################################### Boilerplate END ######################################

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
RUN dnf update -y && \
    dnf upgrade -y

# Install packages
# IGNORE: additional package not required right now: python3, vim, gcc, g++, alpine-sdk 
RUN dnf install epel-release -y
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
    openssl-devel \
    # -- custom \
    jq \
    findutils \
    # -- logging \
    openssh-clients \
    asciinema \
    # ttyd \
    neovim \
    tmux \
    screen \
    " \
    && dnf install -y ${PACKAGES} \
    && rm -rf /var/cache/dnf/* \
    /tmp/* \
    /var/log/* \
    /var/tmp/*  \
    /usr/share/doc/* \
    /usr/share/man/* \ 
    && dnf clean all

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

# Terminal Port is 40020
USER root
EXPOSE 40020
RUN mkdir -p /root/workspace
WORKDIR /root/workspace

# Service 1 -1 - on-init-helper service
COPY ./services/bb-on-init.sh /usr/bin/
COPY ./services/bb-on-init.service /lib/systemd/system/

# Service 1 -2 - Link service to systemd
RUN chmod +x /usr/bin/bb-on-init.sh && \
    ln -sf /lib/systemd/system/bb-on-init.service \
    /etc/systemd/system/multi-user.target.wants/bb-on-init.service

# Service 2 - terminal service
COPY ./services/bb-terminal.sh /usr/bin/
COPY ./services/bb-terminal.service /lib/systemd/system/

# Link service to systemd
RUN chmod +x /usr/bin/bb-terminal.sh && \
    ln -sf /lib/systemd/system/bb-terminal.service \
    /etc/systemd/system/multi-user.target.wants/bb-terminal.service

# Set systemd as entrypoint.
ENTRYPOINT [ "/sbin/init", "--log-level=err" ]