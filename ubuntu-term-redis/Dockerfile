# Dockerfile
# Author: Alper Reha YAZGAN
# alperreha/bb-ubuntu:22.04-term-redis-v1.0.0
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

# redis-server  https://www.digitalocean.com/community/tutorials/how-to-install-and-secure-redis-on-ubuntu-22-04

# Install redis-server required packages
RUN apt-get update

# Install redis-server required packages
RUN apt-get update && \ 
    apt-get install -y redis-server


RUN systemctl enable redis-server

# remove unnecessary files in ubuntu before commit
RUN rm -rf /var/cache/apt/* \
    /var/tmp/* \
    && apt-get clean

