# Dockerfile
# Author: Alper Reha YAZGAN
# alperreha/bb-ubuntu:22.04-term-couchbase76-v1.0.0
# stage 1 - build
FROM alperreha/bb-ubuntu:22.04-term-v1.0.0


LABEL org.opencontainers.image.authors="Alper Reha YAZGAN" \
    org.opencontainers.image.description="Bulut Bilisimciler Hands-on Lab Environment - Ubuntu 22.04 Mongo-7, ttyd, asciinema, websocat and some utilities" \
    org.opencontainers.image.documentation="https://bulutbilisimciler.com" \
    org.opencontainers.image.licenses="GPL v2.0" \
    org.opencontainers.image.title="Bulut Bilisimciler Ubuntu 22.04 Mongo-7 Terminal-Only" \
    org.opencontainers.image.url="https://bulutbilisimciler.com" \
    org.opencontainers.image.vendor="TT" \
    org.opencontainers.image.version="1.0.0"

# Add some additional env variables
ENV DEBIAN_FRONTEND=noninteractive \
    TZ="Europe/Istanbul"

RUN echo "export PS1='\[\033[01;32m\]\u \[\033[01;34m\]\w\[\033[00m\] $ '" >> /etc/bash.bashrc

# couchbase:7.6  https://docs.couchbase.com/server/current/install/ubuntu-debian-install.html

# Install Couchbase-7.6 required packages
RUN apt-get update

WORKDIR /tmp

ARG COUCHBASE_NAME="couchbase-server"
ARG COUCHBASE_VERSION="7.6.3-4200-1"

RUN curl -O https://packages.couchbase.com/releases/couchbase-release/couchbase-release-1.0-noarch.deb

RUN dpkg -i ./couchbase-release-1.0-noarch.deb

# Install Couchbase:7.6 required packages
RUN apt-get update && \ 
    apt-get install -y couchbase-server=${COUCHBASE_VERSION}


RUN systemctl enable couchbase-server

# remove unnecessary files in ubuntu before commit
RUN rm -rf /var/cache/apt/* \
    /var/tmp/* \
    && apt-get clean

