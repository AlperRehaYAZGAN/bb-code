# Dockerfile
# Author: Alper Reha YAZGAN
# alperreha/bb-ubuntu:22.04-term-mongo7-v1.0.0
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

# mongodb-7: https://www.mongodb.com/docs/manual/tutorial/install-mongodb-on-ubuntu/

# Install Mongo-7 required packages
RUN apt-get update && \ 
    apt-get install -y \ 
    gnupg curl

# To import the MongoDB public GPG key, run the following command:
RUN curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg --dearmor \
    && echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list

# Install Mongo-7 required packages
RUN apt-get update && \ 
    apt-get install -y mongodb-org

RUN systemctl enable mongod

# remove unnecessary files in ubuntu before commit
RUN rm -rf /var/cache/apt/* \
    /var/tmp/* \
    && apt-get clean

